class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :lessions, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :activities, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: {maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, allow_blank: true

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def feed
    Activity.where belong_to_following.or mine_without_follow
  end

  def follow other
    active_relationships.create followed_id: other.id
  end

  def unfollow other
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following? other
    following.include? other
  end

  def learned_words
    Word.learned_by self
  end

  def not_learned_words
    Word.not_learned_by self
  end

  private
  def mine_without_follow
    activities = Activity.arel_table
    activities.grouping(activities[:user_id].eq(id)
      .and(activities[:name].not_in([
              "start_following", "stop_following",
              "get_followed", "get_unfollowed"])))
  end

  def belong_to_following
    activities = Activity.arel_table
    activities[:user_id].in(following_ids)
  end
end
