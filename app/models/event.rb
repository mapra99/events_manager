# frozen_string_literal: true

class Event < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :creator, class_name: 'User'
  has_many :attendings, foreign_key: :event_id
  has_many :attendees, through: :attendings, source: :attendee

  def self.past
    where('date < ?', Date.today)
  end

  def self.upcoming
    where('date >= ?', Date.today)
  end
end
