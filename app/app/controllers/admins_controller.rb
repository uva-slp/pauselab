class AdminsController < ApplicationController
	load_and_authorize_resource :class => false

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end


end
