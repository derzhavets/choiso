class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :alternatives
  has_one :alternative, :class_name => "Alternative", :foreign_key => :proposer_id
  has_many :evaluations, :as => :rater
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :notifications, foreign_key: :recipient_id
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  def proposers_of(showable, user)
    alternatives = send("#{showable}_proposed_to".to_sym, user)
    
    proposers = Array.new
    
    alternatives.each do |alternative|
      usr = User.find(alternative.proposer.id)
      proposers << usr
    end
    
    return proposers.uniq 
  end
  
  def proposals_by(showable, user)
    alternatives = send("#{showable}_proposed_by".to_sym, user)
    return alternatives
  end


    
  
  def alternatives_proposed_to(user)
    alternatives.where("user_id = ? AND proposer_id != ?", user.id, user.id)
  end
  
  def alternatives_proposed_by(user)
    alternatives.where(proposer_id: user.id)
  end
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
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
