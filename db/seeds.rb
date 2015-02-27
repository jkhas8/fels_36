# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}

# Categories
10.times do |n|
  name = Faker::Lorem.sentence(5)
  description = Faker::Lorem.paragraph(50)
  Category.create!(name: name, description: description)
end

# Words
categories = Category.all
categories.each do |category|
  100.times do |n|
    content = Faker::Lorem.word
    meaning = Faker::Lorem.word
    word = category.words.build(content: content, meaning: meaning)
    word.answers.build(content: meaning, correct: true)
    3.times do |a|
      word.answers.build(content: Faker::Lorem.word, correct: false)
    end
    word.save!
  end
end

# Lessions
category = Category.first
user = User.first
lession = category.lessions.create!(user: user)
20.times {|_| lession.results.create! word: category.words.first}

