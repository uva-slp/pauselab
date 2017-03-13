class MassEmailsController < ApplicationController
  load_and_authorize_resource
  # NOTE many methods are handled automatically with load_and_authorize_resource

  def index
    index_respond @mass_emails, :mass_emails
  end

  def new
  end

  def show
  end

  def create
    rl = params[:to] || []
    if rl.size == 0
      rl = nil
    end
    @mass_email.to = rl
    if @mass_email.save
      flash[:notice] = (t 'mass_emails.save_success')
      @to = Array.new
      #Get an array of all users, then add desired groups to email list
      @emails_users = User.pluck(:email, :role)
      @emails_users.each do |eu|
          if rl.include?(eu[1])
            @to.push(eu[0])
          end
      end
      #Email idea submitters if residents requested
      if rl.include?('resident')
        @emails_ideas = Idea.pluck(:email)
        @emails_ideas.each do |ei|
            @to.push(ei)
        end
      end
      #Send e-mail
      @subj = @mass_email.subject
      @body = @mass_email.body
      SlpMailer.email_custom_text(@to, @subj, @body).deliver
      #After email is sent redirect to the mass email console
      redirect_to mass_emails_path
    else
      flash[:error] = (t 'mass_emails.save_error')
      render new_mass_email_path
    end
  end

  def destroy
    @mass_email.destroy
    redirect_to mass_emails_path
  end

  private
    def mass_email_params
      params.require(:mass_email).permit(
          :to,
          :subject,
          :body
          )
    end

end
