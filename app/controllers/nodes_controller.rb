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
end
