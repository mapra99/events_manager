# frozen_string_literal: true

class Event < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date >= ?', Date.today) }

  belongs_to :creator, class_name: 'User'
  has_many :attendings, foreign_key: :event_id
  has_many :attendees, through: :attendings, source: :attendee

  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
end
