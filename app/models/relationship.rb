class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :followed, presence: true
  validates :follower, presence: true

  after_create :create_follow_activity
  after_destroy :create_unfollow_activity

  private
  def create_follow_activity
    follower.activities.create!(target: followed, name: 'start_following')
    followed.activities.create!(target: follower, name: 'get_followed')
  end

  def create_unfollow_activity
    follower.activities.create!(target: followed, name: 'stop_following')
    followed.activities.create!(target: follower, name: 'get_unfollowed')
  end
end
