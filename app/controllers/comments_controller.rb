class CommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment ||= Comment.new(params[:comment])
    comment.creator ||= current_user
    comment.event ||= event

    if comment.save
      redirect_to event_path(event)
    else
      flash[:error] = "save failed"
      redirect_to url_to
    end
  end

end
