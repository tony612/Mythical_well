# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:set_base, :update_base, :my_events, :index, :follow, :unfollow]
  def index
    @user = current_user
    @friends = User.all
    render 'friends'

  end
  def show
    @user = User.find(params[:id])
  end

  def set_base
  end

  def update_base 
    if current_user.update_attributes params[:user]
      flash[:success] = "恭喜，基本资料更新成功"
      redirect_to set_base_user_path(current_user)
    else
      render action: 'set_base'
    end
  end

  def my_events
    @events = current_user.events.order('start_date DESC').limit(5)
  end

  def followers
    @user = User.find(params[:id])
    @friends = @user.followers
    render 'friends'
  end

  def followees
    @user = User.find(params[:id])
    @friends = @user.followed_users
    render 'friends'
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow!(@user) if current_user != @user

    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow!(@user) if current_user != @user
    redirect_to @user
  end
end
