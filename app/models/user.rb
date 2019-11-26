# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_events, foreign_key: :creator_id, class_name: 'Event'
  has_many :attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :attendings, source: :attended_event

  validates :name, presence: true, uniqueness: true

  def upcoming_events
    attended_events.upcoming
  end

  def previous_events
    attended_events.past
  end
end
