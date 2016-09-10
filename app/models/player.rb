class Player < ActiveRecord::Base

  has_many :player_stats, class_name: "Measurable"
  has_many :seasons, through: :player_stats
  has_many :rankings
  has_many :sheets, through: :rankings

  def stats_for(year)
    season_id = Season.find_by(season: year)
    self.player_stats.where(season_id: season_id)[0]
  end

  def player_rank(sheet)
    self.rankings.find_by(sheet_id: sheet.id).player_rank
  end

  def total_points(sheet, year)
    (self.stats_for(year)[:pass_yards] * sheet.pass_yard_pts) + (self.stats_for(year)[:pass_tds] * sheet.pass_td_pts) + (self.stats_for(year)[:rush_yards] * sheet.rush_yard_pts) + (self.stats_for(year)[:interceptions] * sheet.int_pts) + (self.stats_for(year)[:rush_tds] * sheet.rush_td_pts) + (self.stats_for(year)[:receptions] * sheet.rec_pts) + (self.stats_for(year)[:receive_yards] * sheet.rec_yard_pts) + (self.stats_for(year)[:receive_tds] * sheet.rec_td_pts)
  end

  def adj_proj(sheet, year)
    @pos_data = {
      "QB" => {correlation_str: 0.60, avg_proj: sheet.avg_qb_proj},
      "RB" => {correlation_str: 0.48, avg_proj: sheet.avg_rb_proj},
      "WR" => {correlation_str: 0.42, avg_proj: sheet.avg_wr_proj},
      "TE" => {correlation_str: 0.62, avg_proj: sheet.avg_te_proj},
    }
    if self.player_stats.where(season: year)
      (@pos_data[self.position][:correlation_str] * (self.total_points(sheet, year) - @pos_data[self.position][:avg_proj])) + @pos_data[self.position][:avg_proj]
    else
      0
    end
  end

end
