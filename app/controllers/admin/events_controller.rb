class Admin::EventsController < Admin::ApplicationController
  def index
    @events = Event.includes(:user).includes(:tags).order('start_date DESC').page(params[:page]).per(10)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to admin_events_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to admin_events_path
    else
      redirect_to admin_events_path
    end

  end
end
