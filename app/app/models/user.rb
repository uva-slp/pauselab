class User < ApplicationRecord

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	    :recoverable, :rememberable, :trackable, :validatable

	# user avatar
	has_attached_file :avatar,
		:styles => { :medium => "300x300>", :thumb => "100x100#" },
		:default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	validates :first_name, :last_name, :email, :password, presence: true
	validates :email, uniqueness: true

  has_many :proposals, dependent: :destroy
	has_many :proposal_comments, dependent: :destroy
  has_many :blogs, dependent: :destroy

	enum role: [:admin, :steerer, :artist, :moderator, :resident, :super_artist]

	def change_role(new_role)
		self.role = new_role
	end

	after_initialize :set_default_role, :if => :new_record?
	def set_default_role
		self.role ||= :resident
	end

	def self.to_csv
		self.gen_csv %w{id created_at fullname email phone role}
	end

  def fullname
    "#{first_name} #{last_name}"
  end
end
