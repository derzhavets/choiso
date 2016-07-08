class CriticalEvaluation < ActiveRecord::Base
  belongs_to :alternative
  belongs_to :rater, :class_name => "User"
  serialize :critical_points
end
