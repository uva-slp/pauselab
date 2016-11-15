class AdminsController < ApplicationController

	load_and_authorize_resource :class => false
	# layout :no_container

	def index
		# render :layout => 'no_container'
	end

	def index_users
		@users = User.all
	end

	def show_user
		@user = User.find(params[:num])
	end

	# def show_user_info
	# 	# @user = User.
	# 	# @user = User.first
	# 	render 'hello world'
	# end

	def change_phase

	end

	def edit_phase
		@phase = Phase.get_current
	end

end
