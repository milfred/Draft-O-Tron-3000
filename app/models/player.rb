class Player < ActiveRecord::Base
  has_many :player_stats, class: "Measurable"
  has_many :rankings
end
