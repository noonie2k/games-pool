class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required

  protected
  def login_required
    unless session[:user_id] && User.find(session[:user_id])
      redirect_to login_path, notice: 'The requested action requires you to log in'
    end
  end
end
