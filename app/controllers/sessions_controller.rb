# frozen_string_literal: true

class SessionsController < ApplicationController
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
