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

	def change_phase
		new_phase = params[:phase]
		@phase = Phase.get_current
		@phase.phase = new_phase.to_i
		@phase.save
		render 'edit_phase'
	end

	def edit_phase
		@phase = Phase.get_current
	end

end
