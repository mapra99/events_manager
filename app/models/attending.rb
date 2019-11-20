class Attending < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, foreign_key: :event_id, class_name: 'Event'
end
