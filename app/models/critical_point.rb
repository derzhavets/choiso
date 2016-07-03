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
    @critical_points = self.where(point_type: traits.singularize.capitalize)
    @points = Array.new
    
    @critical_points.each do |cp|
      @points << cp.point
    end
    
    return @points
  end
  
  def already_exists?
    CriticalPoint.exists?(:alternative_id => self.alternative_id, 
                  :point_type => self.point_type, :point_id => self.point_id, 
                  :proposer_id => self.proposer_id, :user_id => self.user_id)
  end
end
