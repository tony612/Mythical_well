# -*- coding: utf-8 -*-
class MessagesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @messages = current_user.messages.includes(:comment).recent.page params[:page]
    #current_user.read_messages(@messages)
    #p @messages.first
    @messages.unread.update_all(:is_read => true)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to user_messages_path(current_user)
  end
end
