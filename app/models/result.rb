class Result < ActiveRecord::Base
  belongs_to :lession
  belongs_to :word
  belongs_to :answer
end
