class FollowshipController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:followship][:followed_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Followship.find(params[:params[:id]]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end
end