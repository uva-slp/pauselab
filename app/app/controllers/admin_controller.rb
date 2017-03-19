class AdminController < ApplicationController

	load_and_authorize_resource :class => false
	# layout :no_container

	def index
		# render :layout => 'no_container'
	end

	def change_phase
		new_phase = params[:phase]
		@current = Iteration.get_current
    #TODO: prevent invalid values from updating status
		@current.status = new_phase.to_i
		authorize! :update, @current
		@current.save
                if @current.status == "voting"
                    @to = Array.new
                    #Get an array of all users, then add desired groups to email list
                    @emails_users = User.pluck(:email, :role)
                    @emails_users.each do |eu|
                        @to.push(eu[0])
                    end
                    @subj = "PauseLab - Voting Period Now Open"
                    @body = "Dear PauseLab users, the voting period for proposal submissions is now open!"
                    SlpMailer.email_custom_text(@to, @subj, @body).deliver
                end
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

end
