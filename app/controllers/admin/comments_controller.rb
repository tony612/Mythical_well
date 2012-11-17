class Admin::CommentsController < Admin::ApplicationController
  def index
    @comments = Comment.order("created_at DESC").page(params[:page]).per(10)
  end
end

