class Alternative < ActiveRecord::Base
  belongs_to :user
  has_many :evaluations, :as => :rateable
  validates :name, length: { minimum: 5, maximum: 60 }
end
