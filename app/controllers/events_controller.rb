# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render html: 'Error'
    end
  end

  def index
    @upcoming_events = Event.upcoming.includes(:creator)
    @past_events = Event.past.includes(:creator)
  end

  def show
    @event = Event.includes(:creator, :attendees).find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :description, :location)
  end
end
