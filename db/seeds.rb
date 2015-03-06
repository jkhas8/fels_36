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

# Sample category
my_category = Category.create!(name: "Kanji for JLPT 4",
                            description: "For all of you")
contents = %w{校 大 東 水 先 男 右 西 話 友 午 川 左 高 百 母 上 読 八 生 北 国}
means = ["trường học", "to", "hướng đông", "nước", "trước", "nam", "bên phải",
         "hướng tây", "câu chuyện", "bạn", "giữa trưa", "sông", "bên trái",
         "cao", "một trăm", "mẹ", "bên trên", "đọc", "tám", "sống",
         "hướng bắc", "đất nước"]
contents.each_with_index do |content, i|
  meaning = means[i]
  word = my_category.words.build content: content, meaning: meaning
  word.answers.build content: meaning, correct: true
  3.times do |_|
    begin
      other_answer = means[Random.rand(means.length)]
    end until other_answer != meaning
    word.answers.build content: other_answer, correct: false
  end
end
my_category.save!

