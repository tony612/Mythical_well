# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:set_base, :update_base, :my_events]
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
  end
end
