class Alternative < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable
  has_many :notifications, :as => :notifiable
  has_many :requests, :as => :evaluable
  
  has_many :critical_points, dependent: :destroy
  
  #experiment
  has_many :weaknesses, :through => :critical_points, :source => :point, :source_type => 'Weakness'
  has_many :strengths, :through => :critical_points, :source => :point, :source_type => 'Strength'
  #experiment
  
  validates :name, length: { minimum: 5, maximum: 60 }
end
