class Requirement < ActiveRecord::Base
  belongs_to :alternative
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  
  def self.proposed_by(user)
    where(proposer: user)
  end
end
