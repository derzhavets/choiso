class Request < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :evaluable, polymorphic: true
  
  def already_exists?
    Request.exists?(:receiver_id => self.receiver_id, 
                    :sender_id => self.sender_id, :evaluable_id => self.evaluable_id, 
                    :collectible_type => self.collectible_type)
  end
end
