class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :followed, presence: true
  validates :follower, presence: true

  after_create :create_follow_activity
  after_destroy :create_unfollow_activity

  private
  def create_follow_activity
    follower.activities.create!(target_type: "Followed",
                                target_id: followed.id, action_type: 1)
    followed.activities.create!(target_type: "Follower",
                                target_id: follower.id, action_type: 1)
  end

  def create_unfollow_activity
    follower.activities.create!(target_type: "Followed",
                                target_id: followed.id, action_type: 4)
    followed.activities.create!(target_type: "Follower",
                                target_id: follower.id, action_type: 4)
  end
end
