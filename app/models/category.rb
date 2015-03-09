class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessions, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :lessions

  def words_learned_by user
    self.words.learned_by user
  end

  def words_not_learned_by user
    self.words.not_learned_by user
  end
end
