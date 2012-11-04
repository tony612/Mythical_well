class CommentsController < ApplicationController
  before_filter :find_event, :authenticate_user!
  def create
    comment = @event.comments.build(params[:comment])
    current_user.comments << comment
    respond_to do |format|
      if comment.save
        @comments = @event.comments
        @comment = comment
        #PrivatePub.publish_to("/messages_unread/username1", hash: "TestForPub")
        format.html {redirect_to @event}
        format.js {render "create", :locals => {:count => @event.user.messages.count} }
      else
        redirect_to @event
      end
    end
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end
end
