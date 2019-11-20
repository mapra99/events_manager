# frozen_string_literal: true

module ApplicationHelper
  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
