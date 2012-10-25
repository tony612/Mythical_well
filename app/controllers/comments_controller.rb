class CommentsController < ApplicationController
  before_filter :find_event
  def create
    @comment = @event.comments.build(params[:comment])

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
