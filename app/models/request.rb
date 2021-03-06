class Request < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :evaluable, polymorphic: true
  belongs_to :collectible, polymorphic: true
  
  def already_exists?
    Request.exists?(:receiver_id => self.receiver_id, 
                    :sender_id => self.sender_id, :evaluable_id => self.evaluable_id, 
                    :collectible_id => self.collectible_id)
  end
  
  def send_to(friend_id)
    self.receiver = User.find(friend_id)
    self.save unless self.already_exists?
  end
end
