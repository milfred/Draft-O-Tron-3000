class Player < ActiveRecord::Base

  has_many :player_stats, class_name: "Measurable"
  has_many :seasons, through: :player_stats
  has_many :rankings
  has_many :sheets, through: :rankings

  def stats_for(year)
    season_id = Season.find_by(season: year)
    self.player_stats.where(season_id: season_id)[0]
  end

end
