class Player < ActiveRecord::Base

  has_many :player_stats, class_name: "Measurable"
  has_many :seasons, through: :player_stats
  has_many :rankings
  has_many :sheets, through: :rankings

  def self.search(search_term)
    where('lower(name) LIKE ?', "%#{search_term.downcase}%")
  end

  def stats_for(year)
    season_id = Season.find_by(season: year)
    self.player_stats.where(season_id: season_id)[0]
  end

  def player_rank(sheet)
    self.rankings.find_by(sheet_id: sheet.id).player_rank
  end

  def total_points(sheet, year)
    stats = self.stats_for(year)
    (stats[:pass_yards] * sheet.pass_yard_pts) + (stats[:pass_tds] * sheet.pass_td_pts) + (stats[:rush_yards] * sheet.rush_yard_pts) + (stats[:interceptions] * sheet.int_pts) + (stats[:rush_tds] * sheet.rush_td_pts) + (stats[:receptions] * sheet.rec_pts) + (stats[:receive_yards] * sheet.rec_yard_pts) + (stats[:receive_tds] * sheet.rec_td_pts)
  end

  def adj_proj(sheet, year)
    pos_data = {
      "QB" => {correlation_str: 0.60, avg_proj: sheet.avg_qb_proj},
      "RB" => {correlation_str: 0.48, avg_proj: sheet.avg_rb_proj},
      "WR" => {correlation_str: 0.42, avg_proj: sheet.avg_wr_proj},
      "TE" => {correlation_str: 0.62, avg_proj: sheet.avg_te_proj},
    }

    if self.player_stats.where(season: year) && self.total_points(sheet, year) != 0
      (pos_data[self.position][:correlation_str] * (self.total_points(sheet, year) - pos_data[self.position][:avg_proj])) + pos_data[self.position][:avg_proj]
    else
      0
    end
  end

  def draft_status(sheet)
    status = self.rankings.find_by(sheet_id: sheet.id).status
    if status == 0
      return "available"
    elsif status == 1
      return "targeted"
    elsif status == 2
      return "drafted"
    elsif status == 3
      return "unavailable"
    end
  end

end
