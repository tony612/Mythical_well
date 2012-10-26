# -*- coding: utf-8 -*-
class UsersController < ApplicationController
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
end
