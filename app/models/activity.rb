class Activity < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  scope :recent_first,  ->{order(created_at: :desc)}
end
