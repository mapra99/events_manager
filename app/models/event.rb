# frozen_string_literal: true

class Event < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :creator, class_name: 'User'
end
