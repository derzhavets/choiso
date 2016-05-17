class Alternative < ActiveRecord::Base
  belongs_to :user
  has_many :evaluations, :as => :rateable
  validates :name, length: { minimum: 5, maximum: 60 }
  
  def evaluated_by(user)
    evaluations.where(rater_id: user.id)
  end
end
