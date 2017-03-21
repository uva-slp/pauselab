class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  def create
    super
    # at this point the resource is created, but now we change role to artist
    resource.role = User.roles[:artist]
    resource.save
    @to = resource.email
    @name = resource.first_name
    SlpMailer.email_custom_text(@to, "Welcome to PauseLab " + @name, "Welcome to PauseLab " + @name + ". Your account was successfully created.").deliver
  end

  private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end

end
