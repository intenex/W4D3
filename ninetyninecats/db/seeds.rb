# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  User.create(user_name: Faker::Internet.username, password: Faker::Internet.password)
end

50.times do
  Cat.create(user_id: User.all.sample.id, color: Cat::CAT_COLORS.sample, name: Faker::Name.name, sex: %w(M F).sample, birth_date: Faker::Date.between(10.years.ago, 1.year.ago))
end

500.times do
  CatRentalRequest.create(user_id: User.all.sample.id, status: CatRentalRequest::STATUS_STATES.sample, cat_id: Cat.all.sample.id, start_date: Faker::Date.between(10.years.ago, 5.years.ago), end_date: Faker::Date.between(5.years.ago, 1.year.ago))
end

#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

# how to make multiple sessions
# create a new database table for sessions that match to users
# users have many sessions
# sessions belong to a user
# find a user by matching the current session[:session_token] to a session_token in the sessions database table and finding the associated user