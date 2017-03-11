class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  enable_authorization unless :devise_controller?

  # adding below for mass assignment of user fields
  before_action :configure_permitted_parameters, if: :devise_controller?

  # strong params config to work with cancan
  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # setting locale during the lifetime of this request
  before_action do
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # catch unauthorization exception message
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  # apply locale to the url route if it is not the default
  def default_url_options
    { locale: I18n.locale != I18n.default_locale ? I18n.locale : nil }
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(User) && resource.admin?
      admin_overview_url
    elsif (resource.is_a?(User) && resource.artist?) || (resource.is_a?(User) && resource.super_artist?)
      artist_home_url
    elsif  resource.is_a?(User) && resource.steerer?
      steering_home_url
    else
      super
    end
end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :email, :password, :avatar])
    end

    def index_respond scoped_objs, name
      respond_to do |format|
        format.html
        format.json
        format.csv { send_data scoped_objs.to_csv, filename: "#{name}-#{DateTime.current}.csv"}
      end
    end

    def user_has_admin_access
      return ((not current_user.nil?) and (current_user.admin? or current_user.moderator?))
    end
    helper_method :user_has_admin_access
end
