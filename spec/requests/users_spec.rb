require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  context 'someone not registered nor logged in' do
    it 'can signup' do
    end

    it 'cannot create an event' do
    end

    it 'cannot attend an event' do
    end

    it 'can see an event' do
    end
  end
end
