class Priority < ActiveRecord::Base
  has_many :features

  validates_presence_of :display_name, :color, :level
  validates_numericality_of :level
  
  def priority_level
    "#{self.display_name}: #{self.level}"
  end

  def hash_color
    '#'+self.color
  end
end