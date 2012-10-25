class EventsController < ApplicationController
  def index
    @events = Event.order('start_date DESC')
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
    p @comments, @event.user
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end
end
