# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.includes(:created_events, :attended_events).find(params[:id])
  end
end
