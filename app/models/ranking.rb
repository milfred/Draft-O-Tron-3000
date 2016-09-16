class Ranking < ActiveRecord::Base
  belongs_to :sheet
  belongs_to :player

  default_scope { order('player_rank') }
end
