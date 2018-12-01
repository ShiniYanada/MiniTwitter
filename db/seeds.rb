# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Yana',
          email: 'ysthon@gmail.com',
          identifier: 'yanasinn',
          password: 'password',
          password_confirmation: 'password')

10.times do |n|
  name = Faker::Name.name
  email = "test-#{n}@example.com"
  identifier = "test-#{n}"
  password = "password"
  password_confirmation = "password"
  User.create(
    name: name,
    email: email,
    identifier: identifier,
    password: password,
    password_confirmation: password)
end

user = User.first

50.times do
  content = Faker::Lorem.sentence(5)
  user.posts.create(content: content)
end

all_users = User.all
users = all_users[1..10]
user = User.first
users.each{ |following| user.follow(following) }
users.each{ |follower| follower.follow(user) }
