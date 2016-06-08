class Example < ActiveRecord::Base
  def self.for_alternative_type(type)
    where(exampleable: "alternatives", exampleable_type: type)
  end
  
  def self.alternative_types_list
    examples = where(exampleable: "alternatives")
    types = Array.new
    
    examples.each do |example|
      types << example.exampleable_type
    end
    
    return types.uniq
  end
end
