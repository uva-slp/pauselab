class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  enable_authorization unless :devise_controller?

  # adding below for mass assignment of user fields
  # NOTE DEPRECATION WARNING: before_filter is deprecated and will be removed in Rails 5.1. Use before_action instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # catch unauthorization exception message
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
    end

    def index_respond_csv scoped_objs, name
      respond_to do |format|
        format.html
        format.csv { send_data scoped_objs.to_csv, filename: "#{name}-#{DateTime.current}.csv"}
      end
    end
end
