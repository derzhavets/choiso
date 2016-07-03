class Alternative < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable, dependent: :destroy
  has_many :notifications, :as => :notifiable, dependent: :destroy
  has_many :requests, :as => :evaluable
  has_many :requests, :as => :collectible
  
  
  has_many :critical_points, dependent: :destroy
  has_many :requirements, dependent: :destroy
  
  #experiments
  has_many :weaknesses, :through => :critical_points, :source => :point, :source_type => 'Weakness'
  has_many :strengths, :through => :critical_points, :source => :point, :source_type => 'Strength'
  #experiment
  
  validates :name, length: { minimum: 5, maximum: 60 }
    
  def critical_points_by(user)
    critical_points.where(proposer: user)
  end
  
  def traits_unassigned_by(trait, user)
    alternaitve.critical_points.reject { |point| point.trait == trait  }
  end
  
  def requirements_by(user)
    requirements.where(proposer_id: user.id)
  end
  
  def self.proposed_by(user)
    where(proposer: user)
  end
end
