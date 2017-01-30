class MassEmailsController < ApplicationController
  load_and_authorize_resource

  def index
    @mes = MassEmail.all
    authorize! :read, @mes  # TODO not sure why this doesn't work automatically
    index_respond_csv @mes, :mass_emails
  end

  def new
    @me = MassEmail.new
  end

  def show
    @me = MassEmail.find(params[:id])
  end

  def create
    @me = MassEmail.new(mass_email_params)
    @rl   = params[:to] || []
    if @rl.size == 0
      @rl = nil
    end
    @me.to = @rl
    if @me.save
      flash[:notice] = 'Your mass email was sent.'
      @to = Array.new
      #Get an array of all users, then add desired groups to email list
      @emails_users = User.pluck(:email, :role)
      @emails_users.each do |eu|
          if @rl.include?(eu[1])
            @to.push(eu[0])
          end
      end
      #Email idea submitters if residents requested
      if @rl.include?('resident')
        @emails_ideas = Idea.pluck(:email)
        @emails_ideas.each do |ei|
            @to.push(ei)
        end
      end
      #Send e-mail
      @subj = @me.subject
      @body = @me.body
      SlpMailer.email_custom_text(@to, @subj, @body).deliver
      redirect_to mass_emails_path
    else
      flash[:error] = 'There was in error in sending the email.'
      render new_mass_email_path
    end
  end

  def destroy
    @me = MassEmail.find(params[:id])
    @me.destroy
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
