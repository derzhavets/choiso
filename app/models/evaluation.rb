class Evaluation < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :rater, polymorphic: true
end
