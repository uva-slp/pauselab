class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	    :recoverable, :rememberable, :trackable, :validatable

	validates :first_name, :last_name, :email, :password, presence: true
	validates :email, uniqueness: true

  has_many :proposals
	has_many :proposal_comments
  has_many :blogs

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
