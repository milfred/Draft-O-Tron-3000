class Ranking < ActiveRecord::Base
  belongs_to :sheet
  belongs_to :player
end
