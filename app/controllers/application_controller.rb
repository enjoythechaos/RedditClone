class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  def logged_in?
    !!current_user
  end

  def current_user
    @curernt_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!
    return nil unless current_user
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["You must be logged in to perform this action."]
      redirect_to new_sessions_url
    end
  end

  def require_moderator
    sub = Sub.find(params[:id])
    unless sub.moderator == current_user
      flash[:errors] = ["You can't edit this unless you're the moderator.  Please try again."]
      redirect_to sub_url(sub)
    end
  end
end
