class EventsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :create]
  def index
    if params[:category]
      @events = Event.where(category: params[:category]).includes(:user).order('start_date DESC').page(params[:page])
      @events_hot = Event.order('start_date DESC').limit(5)
    else
      @events = Event.includes(:user).order('start_date DESC').page(params[:page])
      @events_hot = Event.order('start_date DESC').limit(5)
    end
    #redirect_to root_path
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments.order('created_at')
    @comment = Comment.new
    @events_hot = Event.order('start_date DESC').limit(5)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(params[:event])
    
    respond_to do |format|
      if @event.save
        tags = params[:tags].split(/\W+/)
        @event.tagging tags

        format.html {redirect_to @event}
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
      
    if @event.update_attributes(params[:event])
      tags = params[:tags].split(/\W+/)
      @event.tagging tags
      redirect_to @event
    else
      render action: 'edit'
    end
  end
end
