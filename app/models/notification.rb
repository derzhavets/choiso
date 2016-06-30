class Notification < ActiveRecord::Base
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true
  
  scope :unread, -> { where(read_at: nil) }
  scope :last_ten, -> { last(10).reverse }
  
  def relevant?
    if self.already_exists?
      self.duplicate.created_at < 1.day.ago
    else
      return true
    end
  end
  
  def already_exists?
    Notification.exists?(:recipient_id => self.recipient_id, 
                        :actor_id => self.actor_id, 
                        :notifiable_type => self.notifiable_type,
                        :action => self.action)      
  end
  
  def duplicate
    Notification.where(:recipient_id => self.recipient_id, 
                        :actor_id => self.actor_id, 
                        :notifiable_type => self.notifiable_type,
                        :action => self.action).first     
  end
end
