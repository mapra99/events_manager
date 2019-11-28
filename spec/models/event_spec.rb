# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'all possible associations for a given event' do
    before(:example) do
      @user1 = User.create!(name: 'This is a user name 1', email: 'email1@example.com',
                            password: 'password123', password_confirmation: 'password123')

      @user2 = User.create!(name: 'This is a user name 1', email: 'email2@example.com',
                            password: 'password123', password_confirmation: 'password123')

      @event = Event.create!(title: 'This is an event title', description: 'This is the description of the event',
                             date: 2.days.after, location: 'Example City', creator_id: @user1.id)

      Attending.create!(attendee_id: @user1.id, event_id: @event.id)
      Attending.create!(attendee_id: @user2.id, event_id: @event.id)
    end

    it 'must retrieve the event creator' do
      expect(@event.creator).to eq(@user1)
    end

    it 'must retrieve all the event attendees and the related attendings' do
      expect(@event.attendees).to include(@user1, @user2)
      expect(@event.attendings.count).to eq(2)
    end
  end

  context 'all defined queries for an Event class' do
    before(:example) do
      @user1 = User.create!(name: 'This is a user name 1', email: 'email1@example.com',
                            password: 'password123', password_confirmation: 'password123')

      @user2 = User.create!(name: 'This is a user name 1', email: 'email2@example.com',
                            password: 'password123', password_confirmation: 'password123')

      @event1 = Event.create!(title: 'This is an event title', description: 'This is the description of the event',
                              date: 2.days.after, location: 'Example City', creator_id: @user1.id)

      @event2 = Event.create!(title: 'This is an event 2 title', description: 'This is the description of the event 2',
                              date: 2.days.ago, location: 'Example City', creator_id: @user1.id)

      Attending.create!(attendee_id: @user1.id, event_id: @event1.id)
      Attending.create!(attendee_id: @user2.id, event_id: @event1.id)
    end

    it 'must always sort the events by newest' do
      expect(Event.all).to eq([@event2, @event1])
    end

    it 'must distinguish among past and upcoming events' do
      expect(Event.past).to eq([@event2])
      expect(Event.upcoming).to eq([@event1])
    end
  end

  context 'validations for an event object' do
    before(:example) do
      @user = User.create!(name: 'This is a user name 1', email: 'email1@example.com',
                           password: 'password123', password_confirmation: 'password123')
      @event = Event.new(title: 'This is an event title', description: 'This is the description of the event',
                         date: 2.days.after, location: 'Example City', creator_id: @user.id)
    end

    it 'must have a title' do
      @event.title = ''
      expect(@event.valid?).to eq(false)
    end

    it 'must have a description' do
      @event.description = ''
      expect(@event.valid?).to eq(false)
    end

    it 'must have a date' do
      @event.date = ''
      expect(@event.valid?).to eq(false)
    end

    it 'must have a location' do
      @event.location = ''
      expect(@event.valid?).to eq(false)
    end
  end
end
