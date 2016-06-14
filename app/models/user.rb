class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :alternatives
  has_one :alternative, :class_name => "Alternative", :foreign_key => :proposer_id
  has_many :evaluations, :as => :rater
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :notifications, foreign_key: :recipient_id
  has_many :requests, foreign_key: :receiver_id
  
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  def requests_from(user)
    requests.where(sender: user)
  end
 
  def own_alternatives
    alternatives.where(proposer_id: self.id)
  end
  
  def proposers_of(showable)
    proposals = send("#{showable}".to_sym).where("user_id = ? AND proposer_id != ?", self.id, self.id)
    proposers = Array.new
    
    proposals.each do |proposal|
      proposers << User.find(proposal.proposer.id)
    end
    return proposers.uniq
  end
  
  def alternatives_proposed_by(proposer)
    alternatives.where(proposer_id: proposer.id)
  end
  
  def alternative_proposed_for(user)
    user.alternatives.where(proposer: self)
  end
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
  
  def friends_except_pending
    friends.reject { |user| user if user.created_by_invite? && !user.invitation_accepted? }
  end
  
  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end

  def self.search(param)
    return User.none if param.blank?
    
    param.strip!
    param.downcase!
    (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end
  
end
