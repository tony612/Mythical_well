class NodesController < ApplicationController
  def new
    @node = Node.new
    @parents = Node.where(:classify => 'city')
  end

  def create
    @node = Node.new(params[:node])

    if @node.save
      redirect_to root_path
    end
  end

  def index
    session[:bread_stack] = ""
    @bread_stack = []
    @cities = Node.where(:classify => 'city').order('name').includes(:children)
  end

  def edit
    @node = Node.find(params[:id])
  end

  def update
    @node = Node.find(params[:id])

    if @node.update_attributes(params[:node])
      redirect_to nodes_path
    end
  end
end
