# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authorization', type: :feature do
  context 'someone not registered nor logged in' do
    it 'can signup' do
      visit '/users/sign_up'
      fill_in 'Name', with: 'An Name Example'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'

      expect { click_button 'Sign up' }.to change { User.all.count }.by(1)
    end

    it 'cannot create an event' do
      visit '/events/new'
      expect(page.current_path).to eq('/users/sign_in')
    end

    it 'can see an event, but cannot attend it' do
      user = User.create(name: 'This is a user name', email: 'email@example.com',
                         password: 'password123', password_confirmation: 'password123')

      event = Event.create(title: 'This is an event title', description: 'This is the description of the event',
                           date: 2.days.after, location: 'Example City', creator_id: user.id)

      visit event_path(event)

      expect(page.current_path).to eq(event_path(event))
      expect(page).to have_no_link('I want to attend this')
    end
  end

  context 'a logged in user' do
    before :example do
      @user = User.create(name: 'This is a user name', email: 'email@example.com',
                          password: 'password123', password_confirmation: 'password123')

      sign_in @user
    end

    it 'can create events' do
      visit '/events/new'
      expect(page.current_path).to eq('/events/new')
      fill_in 'Title', with: 'A title for the event'
      fill_in 'Date', with: Date.today
      fill_in 'Location', with: 'Example City'
      fill_in 'Description', with: 'This is the description of the Event'

      expect { click_button 'Create Event' }.to change { Event.all.count }.by(1)
      created_event = Event.all.order(created_at: :desc).first
      expect(created_event.creator).to eq(@user)
    end

    it 'can see an event and attend it' do
      event = Event.create(title: 'This is an event title', description: 'This is the description of the event',
                           date: 2.days.after, location: 'Example City', creator_id: @user.id)

      visit event_path(event)

      expect(page.current_path).to eq(event_path(event))
      expect(page).to have_link('I want to attend this')
    end
  end
end
