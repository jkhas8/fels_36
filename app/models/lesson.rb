class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :results
  accepts_nested_attributes_for :results

  after_create :create_new_lesson_activity
  after_update :create_finish_lesson_activity

  def check_correct_answer
    self.results.select{|result|
      result.answer.correct? unless result.answer.nil?}.count
  end

  private
  def create_new_lesson_activity
    user.activities.create! target: self, name: 'start_learning'
  end

  def create_finish_lesson_activity
    user.activities.create! target: self, name: 'finish_learning'
  end
end
