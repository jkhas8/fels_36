class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessions, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  def words_learned_by user
    user.lessions.select{|l| l.category == self}.
      map(&:results).flatten.map(&:word)
  end
end
