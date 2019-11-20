# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to @user
    else
      render html: 'error'
    end
  end

  def show
    @user = User.includes(:created_events).find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
