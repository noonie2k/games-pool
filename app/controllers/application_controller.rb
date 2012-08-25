class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required

  protected
  def login_required
    unless logged_in_user
      redirect_to login_path, notice: 'The requested action requires you to log in'
    end
  end

  def admin_login_required
    unless logged_in_user && logged_in_user.admin
      redirect_to root_path
    end
  end

  def logged_in_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
