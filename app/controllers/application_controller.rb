# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :make_bread

  private

  def make_bread
    nodes = []
    if session[:bread_stack]
      nodes = session[:bread_stack].split('|')
    end
    stack = nodes.map{|n| Node.find_by_short_name(n)}
    #p stack
    unless @bread_stack
      @bread_stack = stack
    end
  end

end
