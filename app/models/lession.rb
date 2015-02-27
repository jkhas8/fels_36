class Lession < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :results
  accepts_nested_attributes_for :results
end
