class CriticalPoint < ActiveRecord::Base
  belongs_to :alternative
  belongs_to :point, polymorphic: true
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable, dependent: :destroy
  
  def self.proposed_by(user)
    where(proposer: user)
  end
  
  def self.points_of_type(traits)
    self.where(point_type: traits.singularize.capitalize).map { |cp| cp.point }
  end
  
  def already_exists?
    CriticalPoint.exists?(:alternative_id => self.alternative_id, 
                  :point_type => self.point_type, :point_id => self.point_id, 
                  :proposer_id => self.proposer_id, :user_id => self.user_id)
  end

  def alternative_index
    self.user.own_alternatives.index(self.alternative)
  end
end
