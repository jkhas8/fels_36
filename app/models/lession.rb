class Lession < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :results
  accepts_nested_attributes_for :results

  after_create :create_new_lession_activity
  after_update :create_finish_lession_activity

  def check_correct_answer lession
    lession.results.select{|r| r.answer.correct?}.count
  end

  private
  def create_new_lession_activity
    user.activities.create!(target_type: "Lession",
                            target_id: id, action_type: 1)
  end

  def create_finish_lession_activity
    user.activities.create!(target_type: "Lession",
                            target_id: id, action_type: 4)
  end
end
