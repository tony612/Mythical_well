# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :make_bread

  private

  def make_bread
    unless @bread_stack
      @bread_stack = ["城市", "广州", "华工(大学城校区)"]
    end
  end

end
