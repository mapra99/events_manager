class AttendingsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_new_attendees

  def create
    @event = Event.find(params[:event_id])
    attendee = User.find(params[:attendee_id])

    if @event && attendee
      attendee.attendings.create(event_id: @event.id)
      redirect_to @event
    else
      render html: 'An Error Ocurred'
    end
  end

  private

  def only_new_attendees
    @event = Event.find(params[:event_id])
    attendee = User.find(params[:attendee_id])

    redirect_to @event if @event.attendees.include? attendee
  end
end
