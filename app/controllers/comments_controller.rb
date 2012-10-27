class CommentsController < ApplicationController
  before_filter :find_event, :authenticate_user!
  def create
    @comment = @event.comments.build(params[:comment])
    current_user.comments << @comment

    if @comment.save
      redirect_to @event
    else
      redirect_to @event
    end
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end
end
