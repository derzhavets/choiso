class Strength < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable
  has_many :notifications, :as => :notifiable
  has_many :requests, :as => :evaluable
end
