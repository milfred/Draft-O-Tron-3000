class Player < ActiveRecord::Base
  has_many :player_stats, class_name: "Measurable"
  has_many :rankings
end
