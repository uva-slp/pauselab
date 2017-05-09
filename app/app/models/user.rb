class User < ApplicationRecord

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	    :recoverable, :rememberable, :trackable, :validatable

	# user avatar
	has_attached_file :avatar,
		:styles => { :medium => "300x300#", :thumb => "100x100#" },
		:default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :avatar, :less_than => 5.megabytes

	validates :first_name, :last_name, :email, presence: true
	validates :password, presence: true, :if => :password_required?
	validates :email, uniqueness: true

  has_many :proposals, dependent: :destroy
	has_many :proposal_comments, dependent: :destroy
  has_many :blogs, dependent: :destroy

	# enumeration of user roles -- if adding more, be sure to modify order_roles below
	enum role: [:admin, :steerer, :artist, :moderator, :resident, :super_artist]

	# prioritize values from the enum so they present in the given order on a form
	def self.order_roles(roles)
		return [
			'admin',
			'moderator',
			'steerer',
			'super_artist',
			'artist',
			'resident',
		].select{|r| roles.include? r.to_s }
	end

	def self.roles_ordered
		return User.order_roles(User.roles.keys.to_a)
	end

	def change_role(new_role)
		self.role = new_role
	end

	after_initialize :set_default_role, :if => :new_record?
	def set_default_role
		self.role ||= :resident
	end

	def fullname
    "#{first_name} #{last_name}"
  end

	def self.to_csv options={}
		self.gen_csv %w{id created_at fullname email phone role}
	end

	# taken from http://stackoverflow.com/a/7156008
	def self.valid_attribute?(attr, value)
	  mock = self.new(attr => value)
	  if mock.valid?
	    true
	  else
			# for some reason has_key fails, so loop manually
			mock.errors.keys.each do |e|
				if e.to_s == attr.to_s
					return false
				end
			end
			true
	  end
	end

	def update_attributes_manual(attrs)
		success = true
		attrs.each do |k, v|
			if k.to_s == 'email' && v.to_s == self.email
				next	# otherwise email fails uniqueness check
			end
			success = success && (User.valid_attribute? k, v)
		end
		if success
			attrs.each do |k, v|
				success = success && (self.update_attribute k, v)
			end
		end
		success
	end

end
