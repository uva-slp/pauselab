class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	validates_presence_of :first_name, :on => :create
	validates_presence_of :last_name, :on => :create
	validates_presence_of :phone, :on => :create

	# this is creating a static array of roles (%w creates words by separating in whitespace)
	Roles = %w[admin steerer artist moderator].freeze

end
