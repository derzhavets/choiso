class Evaluation < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :rater, polymorphic: true
  
  def self.own
    where(rater_id: self.last.rateable.user.id)
  end
end
