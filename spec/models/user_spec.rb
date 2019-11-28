require 'rails_helper'

RSpec.describe User, type: :model do
  context 'a created user' do
    before(:example) do
      @user = User.create(name: 'This is a user name',
                          email: 'email@example.com',
                          password: 'password123',
                          password_confirmation: 'password123')
    end

    it 'can create multiple events' do
      expect {
        @user.created_events.create(title: 'This is an event title',
                                    description: 'This is the description of the event',
                                    date: Date.today,
                                    location: 'Example City')
  
        @user.created_events.create(title: 'This is an event 2 title',
                                    description: 'This is the description of the event 2',
                                    date: 2.days.ago,
                                    location: 'Example City')
      }.to change {@user.created_events.count}.by(2)
    end
  end
end
