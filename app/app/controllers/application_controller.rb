class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # adding below for mass assignment of user fields
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
      	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
      end

end
