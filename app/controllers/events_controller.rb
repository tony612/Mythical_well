# encoding: utf-8
class EventsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :create]
  def index
    if params[:category]
      @events = Event.where(category: params[:category]).includes(:user).order('start_date DESC').page(params[:page])
    elsif params[:tag]
      @events = Tag.find_by_name(params[:tag]).events.includes(:user).order('start_date DESC').page(params[:page])
    else
      @events = Event.includes(:user).order('start_date DESC').page(params[:page])
    end
    @events_hot = Event.order('start_date DESC').limit(5)
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
    date_handle   
    @event = current_user.events.build(params[:event])

    respond_to do |format|
      if @event.save
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
    date_handle

    @event = Event.find(params[:id])
      
    if @event.update_attributes(params[:event])
      #tags = params[:tags].split(/\W+/)
      #@event.tagging tags
      redirect_to @event
    else
      render action: 'edit'
    end
  end

  private

  def date_handle
    t_repeat = params[:date_repeat]
    t_type = params[:date_type]
    t_desc = params[:date_desc]
    if t_repeat == 'no'
      if t_type == 'range' && t_desc.split(' - ').length > 1
        t_start = (t_desc.split(' - ')[0] +' ' + params[:start_time][0]).to_datetime
        t_end = (t_desc.split(' - ')[1] + ' ' + params[:end_time][0]).to_datetime
        params[:event][:start_date], params[:event][:end_date] = t_start, t_end
        params[:event][:date_desc] = "#{t_desc.split(' - ')[0]}到#{t_desc.split(' - ')[1]}的#{params[:start_time][0]}-#{params[:end_time][0]}"
      elsif
        t_arr = t_desc.split(', ')
        if t_arr.length == 1 || (t_type == 'range' && t_desc.split(' - ').length == 1)
          t_start = (t_desc + ' ' + params[:start_time][0]).to_datetime
          t_end = (t_desc + ' ' + params[:end_time][0]).to_datetime
          params[:event][:start_date], params[:event][:end_date] = t_start, t_end
          params[:event][:date_desc] = "#{t_desc}的#{params[:start_time][0]}-#{params[:end_time][0]}"
        else
          t_start = (t_arr[0]+' '+params[:start_time][0]).to_datetime
          t_end = (t_arr[-1] + ' ' + params[:end_time][0]).to_datetime
          params[:event][:start_date], params[:event][:end_date] = t_start, t_end
          params[:event][:date_desc] = t_arr.zip(params[:start_time].zip(params[:end_time]).map{|a| a*'到'}).map{|b| b*'的'} * ';'
        end
      end
    else
      t_begin = params[:repeat_range].split(' - ')[0]
      t_end = params[:repeat_range].split(' - ')[1]
      params[:event][:start_date] = (t_begin + ' ' + params[:start_time][0]).to_datetime
      params[:event][:end_date] = (t_end + ' ' + params[:end_time][0]).to_datetime
      repeat_arr = t_desc.split(', ').map{|t| t.to_datetime.strftime('周%u')}
      params[:event][:date_desc] = "#{t_begin}到#{t_end}中#{repeat_arr*','}的#{params[:start_time][0]}-#{params[:end_time][0]}"
    end
    p params[:event][:start_date], params[:event][:end_date], params[:event][:date_desc]
  end
end
