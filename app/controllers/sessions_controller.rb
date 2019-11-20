# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  
  def new; end

  def create
    user = User.find_by(name: params[:session][:name])
    if user
      login user
      redirect_to user
    else
      render html: 'Error. User not Found'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
