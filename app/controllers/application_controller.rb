class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl
  respond_to :html, :csv

  def require_login
    redirect_to new_session_url if current_user.nil?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end