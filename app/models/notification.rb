class Notification < ActiveRecord::Base
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true
  
  scope :unread, -> { where(read_at: nil) }
  scope :last_ten, -> { last(10).reverse }
  
  def self.generate(action, object)
    if action == "proposed"  
      @notification = Notification.new(recipient: object.user, actor: object.proposer, 
                      notifiable: object, action: action)
      @notification.save if @notification.relevant?    
    elsif action == "asked"
      @notification = Notification.new(recipient: object.receiver, actor: object.sender, action: action)
      @notification.notifiable = object.collectible ? object.collectible : object.evaluable
      @notification.save if @notification.relevant?
    end
  end
  
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
