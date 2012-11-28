# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :make_bread

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = "不好意思哦，你没有权限这么做，如果你一定要的话，请登录正确的帐号"
    redirect_to root_path

  end

  private

  def make_bread
    nodes = []
    if session[:bread_stack]
      nodes = session[:bread_stack].split('|')
    end
    stack = nodes.map{|n| Node.find_by_short_name(n)}
    unless @bread_stack
      @bread_stack = stack
    end
  end

end
