class EventsController < ApplicationController
  before_filter :require_login

  def index
    if params.key? :event
      if params[:event].key? 'end_date(1i)'
        year = params[:event]['end_date(1i)']
        month = Integer(params[:event]['end_date(2i)'])
        time = Time.new(year, month + 1)
      else
        time = Time.now.getlocal
      end
      wherestring = 'occurs_at < ?'
    else
      time = Time.now.getlocal
      wherestring = 'occurs_at >= ?'
    end
    @events = Event.where(wherestring, time).order('occurs_at ASC')
    @by_month = @events.group_by { |event| [ event.occurs_at.year, event.occurs_at.strftime('%B') ] }


    @created_events = current_user.created_events
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(params[:event])
    @event.creator = current_user
    if @event.save
      redirect_to user_events_url, :notice => "Event Created!"
    else
      render "new"
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id]) 
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => "Event Updated!"
    else
      render "edit"
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = current_user.created_events.find(params[:id])
    if @event.destroy
      notice = "Event Destroyed!"
    else
      notice = "Event could not be Destroyed!"
    end
    redirect_to user_events_url, :notice => notice
  end
  

  def attend
    if params[:attend] == "true"
      @event = Event.find params[:id]
      @event.attendees << current_user
      #TODO: Right now can RSVP twice; can be fixed in DB query or here
    else
      @event_attendee = EventAttendee.where(:event_id => params[:id], :user_id => current_user.id)
      @event_attendee.delete_all

    end
    redirect_to @event
  end
end
