class EventsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  def index
    @events = Event.order('start_date DESC')
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(params[:event])
    
    if @event.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end
end
