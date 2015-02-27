class Lession < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :results
  accepts_nested_attributes_for :results

  def check_correct_answer lession
    lession.results.select{|r| r.answer.correct?}.count
  end
end
