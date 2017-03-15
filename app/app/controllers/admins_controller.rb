class AdminsController < ApplicationController

	load_and_authorize_resource :class => false
	# layout :no_container

	def index
		# render :layout => 'no_container'
	end

	def index_users
		@users = User.all.paginate :page => params[:page], :per_page => 25
		authorize! :read, @users
		index_respond @users, :users
	end

	def show_user
		@user = User.find(params[:num])
		authorize! :read, @user
	end
  
  def new_user
    @user = User.new    
  end

  #TODO: Fix this, currently not sending POST params from admins/create_user
  def create_user
    @user = User.new(user_params)
    if @user.save
	    flash[:notice] = ("New user created sucessfully")
	    redirect_to list_users_path
    else
	    flash[:error] = ("Missing fields")
       render new_user_path
    end
  
  end

	def change_phase
		new_phase = params[:phase]
		@current = Iteration.get_current
    #TODO: prevent invalid values from updating status
		@current.status = new_phase.to_i
		authorize! :update, @current
		@current.save
		render 'edit_phase'
	end

# ran into issues comparing strings to symbols
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
		# if prev.status == "progress"
		prev.ended = Time.now
		prev.status = "ended"
		prev.save
		@current = Iteration.new
		@current.save
		# end
		# render json: {current: @current, prev: prev}
		render 'edit_phase'
	end

	def edit_phase
		@current = Iteration.get_current
		# @iterations = Iteration.where :status => "ended"
		# @info = {
		# 	:ideas => @current.ideas.count,
		# 	:votes => @current.votes.count,
		# 	:blogs => @current.blogs.count,
		# 	:proposals => @current.proposals.count,
		# }
		# @phase = Phase.get_current
		authorize! :edit, @current
	end

	def change_role
		@user = User.find(params[:user])
		authorize! :update, @user
    @user.update_attribute :first_name, params[:first_name]
	  @user.update_attribute :last_name, params[:last_name]
    @user.update_attribute :role, params[:role].to_i
    @user.update_attribute :email, params[:email]
		@user.update_attribute :phone, params[:phone]
		render 'show_user'
	end

	def export_data
		# the getter for the webpage with export options
		# no backend logic, just links on the html
		render 'export_data'
	end

	def export_iterations
		@iterations = Iteration.where :status => "ended"
	end

	require 'tempfile'
	require 'zip'

	def export_zip

		@iteration = Iteration.find params[:num]

		ideas_file = Tempfile.new(['ideas', '.txt'])
		proposals_file = Tempfile.new(['proposals', '.txt'])
		blogs_file = Tempfile.new(['blogs', '.txt'])

		zip = Tempfile.new(["export", ".zip"])

		begin

			ideas_file.write @iteration.ideas.to_csv
			ideas_file.flush

			proposals_file.write @iteration.proposals.to_csv
			proposals_file.flush

			blogs_file.write @iteration.blogs.to_csv
			blogs_file.flush

			Zip::OutputStream.open(zip) { |zos| }
			Zip::File.open(zip.path, Zip::File::CREATE) do |zip|
				#Put files in here
				zip.add("ideas.csv", ideas_file.path)
				zip.add("proposals.csv", proposals_file.path)
				zip.add("blogs.csv", blogs_file.path)
			end

			zip_data = File.read(zip.path)
			send_data(zip_data, :type => 'application/zip', :filename => "iter_export_#{@iteration.ended}.zip")

		ensure
			ideas_file.close
			ideas_file.unlink

			zip.close
			zip.unlink
		end

	end

	private
	  def user_params
	    params.require(:user).permit(
	    	:first_name,
	    	:last_name,
	    	:email,
        :password,
	    	:phone
	    	)
	  end

end
