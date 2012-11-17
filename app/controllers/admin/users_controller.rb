class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def edit
    @user = User.find_by_username(params[:id])
  end

  def update
    @user = User.find_by_username(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render action: 'edit'
    end
  end
end

