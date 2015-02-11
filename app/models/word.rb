class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
    reject_if: ->(a){a[:content].blank?}, allow_destroy: true

  validate :check_has_correct_answer

  private
  def check_has_correct_answer
    unless answers.any? {|answer| answer.correct?}
      errors.add(:base, "must have correct answer")
    end
  end
end
