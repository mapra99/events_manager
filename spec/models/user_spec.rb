# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'possible associations for a user that created two events' do
    before(:example) do
      @user = User.create(name: 'This is a user name', email: 'email@example.com',
                          password: 'password123', password_confirmation: 'password123')

      @event1 = Event.create(title: 'This is an event title', description: 'This is the description of the event',
                             date: 2.days.after, location: 'Example City', creator_id: @user.id)
      @event2 = Event.create(title: 'This is an event 2 title', description: 'This is the description of the event 2',
                             date: 2.days.ago, location: 'Example City', creator_id: @user.id)

      Attending.create(attendee_id: @user.id, event_id: @event1.id)
      Attending.create(attendee_id: @user.id, event_id: @event2.id)
    end

    it 'must retrieve all created events' do
      expect(@user.created_events).to include(@event1, @event2)
    end

    it 'must retrieve all attended_events and attendings' do
      expect(@user.attended_events).to include(@event1, @event2)
      expect(@user.attendings.count).to eq(2)
    end

    it 'must distinguish among upcoming past attended events' do
      expect(@user.upcoming_events).to include(@event1)
      expect(@user.previous_events).to include(@event2)
    end
  end

  context 'validations for a user object' do
    before(:example) do
      @user = User.new(name: 'This is a user name', email: 'email@example.com',
                       password: 'password123', password_confirmation: 'password123')
    end

    it 'must have a name' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'must have a name length up to 50 characters' do
      @user.name = 'a' * 51
      expect(@user.valid?).to eq(false)
    end

    it 'must have a valid email format' do
      invalid_emails = ['not_an_email.com', 'myexample@gmail', '@gmail.com',
                        'blabla@', 'blabla', '', 'a' * 246 + '@gmail.com']
      invalid_emails.each do |email|
        @user.email = email
        expect(@user.valid?).to eq(false)
      end
    end

    it 'must have a unique email' do
      @user.save
      user2 = @user.dup

      expect(user2.valid?).to eq(false)
    end
  end
end
