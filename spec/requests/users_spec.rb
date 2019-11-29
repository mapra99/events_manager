# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :feature do
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
      expect(page).to have_no_link('I want to attend this event')
    end
  end
end
