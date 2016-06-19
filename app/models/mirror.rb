class Mirror
  def self.traits_list_for(user)
    list = {}
    
    user.strengths.each do |str|
       
    end   
    
    holiday_supplies = {
      "winter" => { 
        "Christmas" => ["lights", "tree"],
        "New Years" => "champagne glasses"
      },
      "summer" => {
        "July Fourth" => ["BBQ", "flags"]
      },
      "spring" => {
        "Memorial Day" => "BBQ"
      },
      "fall" => {
        "Labor Day" => "hot dogs"
      }
    }
    
    return holiday_supplies
  end  
end