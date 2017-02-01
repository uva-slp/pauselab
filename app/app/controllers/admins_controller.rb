class AdminsController < ApplicationController

	load_and_authorize_resource :class => false
	# layout :no_container

	def index
		# render :layout => 'no_container'
	end

	def index_users
		@users = User.all
		authorize! :read, @users
		index_respond_csv @users, :users
	end

	def show_user
		@user = User.find(params[:num])
		authorize! :read, @user
	end

	def change_phase
		new_phase = params[:phase]
		@phase = Phase.get_current
		@phase.phase = new_phase.to_i
		authorize! :update, @phase
		@phase.save
		render 'edit_phase'
	end

# ran into issues cmoparing strings to symbols
	def next_phase
		@current = Iteration.get_current
		@current.status = case @current.status
				when "ideas" then "proposals"
				when "proposals" then "voting"
				when "voting" then "progress"
				else "progress"
			end
		@current.save
		render json: {:status => @current.status}
	end

	def end_phase
		prev = Iteration.get_current
		if prev.status == "progress"
			prev.ended = Time.now
			prev.status = "ended"
			prev.save
			@current = Iteration.new
			@current.save
		end
		render json: {current: @current, prev: prev}
	end

	def edit_phase
		@current = Iteration.get_current
		@iterations = Iteration.where :status => "ended"
		@info = {
			:ideas => @current.ideas.count,
			:votes => @current.votes.count,
			:blogs => @current.blogs.count,
			:proposals => @current.proposals.count,
		}
		# @phase = Phase.get_current
		authorize! :edit, @current
	end

	def change_role
		@user = User.find(params[:user])
		authorize! :update, @user
		@user.update_attribute :role, params[:role].to_i
		render 'show_user'
	end

	def export_data
		# the getter for the webpage with export options
		# no backend logic, just links on the html
		render 'export_data'
	end

end
