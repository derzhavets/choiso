class Trait < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    type = "ActiveRecord::Type::#{sql_type.to_s.camelize}".constantize.new
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, type, null)
  end
  
  column :id, :integer
  column :resource_name, :string
  column :name, :string
  column :user_id, :integer
  column :proposer_id, :integer
  
  belongs_to :user
  belongs_to :proposer, class_name: "User"

  def save
    @resource = self.resource_name.constantize.new(name: self.name, user_id: self.user_id, 
                                        proposer_id: self.proposer_id)
    if @resource.save
      self.id = @resource.id
      return true
    else
      self.errors[:base] << @resource.errors.full_messages.first
      return false
    end
  end
  
  def object
    self.resource_name.constantize.find(self.id)
  end
end