class Alternative < ActiveRecord::Base
  belongs_to :user
  validates :name, length: { minimum: 5, maximum: 60 }
end
