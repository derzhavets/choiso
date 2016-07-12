class Strength < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable, dependent: :destroy
  has_many :notifications, :as => :notifiable
  has_many :requests, :as => :evaluable
  has_many :requests, :as => :collectible
  has_many :critical_points, :as => :point, dependent: :destroy
  has_many :alternatives, :through => :critical_points
  
  validates_presence_of :name
  validates :name, length: { minimum: 5, maximum: 60 }
  
  def self.except_assigned_for(alternative, strengths)
    strengths.reject { |str| alternative.strengths.include?(str)  }
  end
  
  def critcal_points_for(alternative)
    critical_points.where(alternative_id: alternative.id)
  end
  
  def style
    "btn-success"
  end
  
  def self.proposed_by(user)
    where(proposer: user)
  end
end
