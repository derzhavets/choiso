class Example < ActiveRecord::Base
  def self.for_showable_type(showable, type)
    where(exampleable: showable, exampleable_type: type)
  end
  
  def self.alternative_types_list
    examples = where(exampleable: "alternatives")
    types = Array.new
    
    examples.each do |example|
      types << example.exampleable_type
    end
    
    return types.uniq
  end
  
  def self.types_of(exampleable)
    examples = where(exampleable: exampleable)
    types = Array.new
    
    examples.each do |example|
      types << example.exampleable_type
    end
    
    return types.uniq    
  end  
end
