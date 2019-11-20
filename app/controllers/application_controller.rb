# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  private

  def redirect_if_logged_in
    return unless current_user

    redirect_to current_user
  end
end
