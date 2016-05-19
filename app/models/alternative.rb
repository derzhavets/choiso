class Alternative < ActiveRecord::Base
  belongs_to :user, :class_name => "User"
  belongs_to :proposer, :class_name => "User"
  has_many :evaluations, :as => :rateable
  validates :name, length: { minimum: 5, maximum: 60 }
  
end
