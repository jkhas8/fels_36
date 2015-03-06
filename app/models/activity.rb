class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, polymorphic: true

  validates :user, presence: true

  scope :recent_first,  ->{order(created_at: :desc)}
end
