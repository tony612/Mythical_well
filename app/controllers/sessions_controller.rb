class SessionsController < ApplicationController
  def goto
    @node = Node.find_by_short_name(params[:node])
    str_bread = ""
    if @node.classify == 'school'
      str_bread = "#{@node.parent_short_name}|#{@node.short_name}"
    else
      str_bread = "#{@node.short_name}"
    end
    session[:bread_stack] = str_bread

    redirect_to node_path(@node.short_name)
  end
end
