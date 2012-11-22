# encoding: utf-8
class CommentsController < ApplicationController

  load_and_authorize_resource :comment 

  before_filter :find_event, :authenticate_user!
  def create
    @comment = @event.comments.build(params[:comment])
    current_user.comments << @comment
    respond_to do |format|
      if @comment.save
        @comments = @event.comments
        format.html {redirect_to @event}
        format.js {render "create", :locals => {:count => @event.user.messages.unread.count} }
      else
        @comments = @event.comments
        format.html {redirect_to event_path(@event)}
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @event = Event.find(params[:event_id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:success] = "恭喜，修改成功"
      redirect_to @comment.event
    else
      render event_edit_comment_path(@comment.event, @comment)
    end
  end
  protected

  def find_event
    @event = Event.find(params[:event_id])
  end

end
