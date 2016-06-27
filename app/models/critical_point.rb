class CriticalPoint < ActiveRecord::Base
  belongs_to :alternative
  belongs_to :point, polymorphic: true
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  
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
end
