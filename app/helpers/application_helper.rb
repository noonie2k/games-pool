module ApplicationHelper
  def logged_in_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def icon(name)
    content_tag :i, '', class: name
  end
end
