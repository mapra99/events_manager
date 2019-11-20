# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  u = User.create(name: Faker::Games::WorldOfWarcraft.hero)
end

10.times do
  u = User.all.sample(1).first
  10.times do |j|
    u.created_events.create(title: Faker::Movie.quote,
                            description: Faker::Lorem.paragraph(sentence_count: 30),
                            location: Faker::Nation.capital_city,
                            date: j.days.ago)
  end
end

users = User.all.sample(20)
users.each do |user|
  events = Event.all.sample(10)
  events.each do |event|
    user.attendings.create(event_id: event.id)
  end
end