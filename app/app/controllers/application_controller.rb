class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # adding below for mass assignment of user fields
  # NOTE DEPRECATION WARNING: before_filter is deprecated and will be removed in Rails 5.1. Use before_action instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
      	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
      end

end
