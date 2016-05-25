class Alternative < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable
  has_many :notifications, :as => :notifiable
  validates :name, length: { minimum: 5, maximum: 60 }
  
end
