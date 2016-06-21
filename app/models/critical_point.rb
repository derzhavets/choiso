class CriticalPoint < ActiveRecord::Base
  belongs_to :alternative
  belongs_to :point, polymorphic: true
end
