class Notification < ActiveRecord::Base
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true
  
  scope :unread, -> { where(read_at: nil) }
  scope :last_ten, -> { last(10).reverse }
  
  
  
end
