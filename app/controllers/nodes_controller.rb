class NodesController < ApplicationController
  def index
    session[:bread_stack] = ""
    @bread_stack = []
    @cities = Node.where(:classify => 'city').order('name').includes(:children)
  end
end
