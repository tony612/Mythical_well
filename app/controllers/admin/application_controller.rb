# encoding: utf-8
class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :require_admin

  def require_admin
    if not Setting.admin_emails.include?(current_user.email)
      flash[:warning] = "不好意思，您是不是点错什么地方了？"
      redirect_to root_path
    end
  end

end
