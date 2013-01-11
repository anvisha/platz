class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def index
    @event = Event.find params[:event_id]
    @attendees = @event.attendees
    #TODO: right now to notify, gives csv of emails.  Think of smarter way
    respond_with @attendees do |format|
      format.html
      format.csv { render :text => @attendees.map {|a| a.email }.join(',') }
    end
  end
end
