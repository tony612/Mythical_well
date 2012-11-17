class Admin::NodesController < Admin::ApplicationController
  def index
    @nodes = Node.page(params[:page]).per(10)
  end
  
  def edit
    @node = Node.find(params[:id])
    @parents = Node.where(:classify => 'city')
  end

  def update
    @node = Node.find(params[:id])

    if @node.update_attributes(params[:node])
      redirect_to admin_nodes_path
    else
      render action: 'edit'
    end
  end

  def new
    @node = Node.new
    @parents = Node.where(:classify => 'city')
  end

  def create
    @node = Node.new(params[:node])

    if @node.save
      redirect_to admin_nodes_path
    else
      render action: 'new'
    end
  end

  def destroy
  end
end

