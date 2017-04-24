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
    # Get list of user roles selected for this mass email
    roles = User.roles.keys.select { |role| mass_email_params[:to].include? role.to_s }
    @mass_email.to = roles.to_s
    # Reject is role list is empty
    if !roles.empty? && @mass_email.save
      flash[:notice] = (t 'mass_emails.save_success')
      # Get list of addresses corresponding to those roles
      @to = get_addresses roles
      #Send e-mail
      @subj = @mass_email.subject
      @body = @mass_email.body
      SlpMailer.email_custom_text_bcc(@to, @subj, @body).deliver
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
          :subject,
          :body,
          :to => []
          )
    end

end
