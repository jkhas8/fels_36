# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin
User.create!(name:  "Admin",
             email: "admin@elearning.com.vn",
             password:              "password",
             password_confirmation: "password",
             admin: true)

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
  other_answers = means.select{|mean| mean != meaning}.sample 3
  other_answers.each do |answer|
    word.answers.build content: answer, correct: false
  end
end
my_category.save!

