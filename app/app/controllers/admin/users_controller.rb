class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.paginate :page => params[:page], :per_page => 25
    index_respond @users, :users
  end

  def create
    @user = User.new(user_params)
    #@user.update_attribute :role, params[:role].to_i	# doesn't work like other params
    if @user.save
      flash[:notice] = (t 'admins.create_user_success')
      redirect_to admin_users_path
    else
      flash[:error] = (t 'admins.create_user_fail')
      render 'new'
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
    # very difficult to do normal update due to "Blank password" issue
    # instead we validate and update the parameters individually
    success = @user.update_attributes_manual user_params
    if success
      flash[:notice] = (t 'admins.update_user_success')
      redirect_to admin_users_path
    else
      flash[:error] = (t 'admins.update_user_fail')
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = (t 'admins.remove_user_success')
    else
      flash[:error] = (t 'admins.remove_user_fail')
    end
    redirect_to admin_users_path
  end

  private
    def user_params
      up = params.require(:user).permit(
        :avatar,
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :phone,
        :role
        )

      # advice from http://stackoverflow.com/a/27993366
      if !up[:password].present? and !up[:password_confirmation].present?
        up.delete(:password)
        up.delete(:password_confirmation)
      end
      return up
    end

end
