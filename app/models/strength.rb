class Strength < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable
  has_many :notifications, :as => :notifiable
  has_many :requests, :as => :evaluable
  has_many :critical_points, :as => :point, dependent: :destroy
  
  #experiment
  has_many :alternatives, :through => :critical_points
  
  def self.except_assigned_for(alternative, strengths)
    strengths.reject { |str| alternative.strengths.include?(str)  }
  end
end
