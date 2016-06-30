class Proposal < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    type = "ActiveRecord::Type::#{sql_type.to_s.camelize}".constantize.new
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, type, null)
  end
  
  column :user_id, :integer
  column :proposer_id, :integer
  column :showable, :string
  column :exampleable_type, :string
  
  belongs_to :user
  belongs_to :proposer, class_name: "User"
  
  def proposals
    if self.proposer.id == User.choiso_account_id
      @proposals = Example.for_showable_type(self.showable, self.exampleable_type)
    else
      @proposals = self.user.proposals_for(self.showable, self.proposer)
    end
    return @proposals
  end
  
  def title
    if self.proposer.id == User.choiso_account_id
      @title = "#{self.exampleable_type.capitalize} #{self.showable.singularize.humanize} examples by Choiso"
    else
      @title = "#{self.showable.humanize.capitalize} proposals by #{self.proposer.full_name}"
    end
    return @title
  end
  
end