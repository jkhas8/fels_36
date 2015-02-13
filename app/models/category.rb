class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessions, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :lessions

  def words_learned_by user
    user.lessions.select{|l| l.category == self}.
      map(&:results).flatten.map(&:word).uniq
  end

  def words_not_learned_by user
    Word.all.select{|l| l.category == self}.select do |w|
      !user.lessions.map(&:results).flatten.map(&:word).include? w
    end
  end
end
