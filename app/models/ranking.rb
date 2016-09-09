class Ranking < ActiveRecord::Base

  belongs_to :sheet
  belongs_to :player

  def total_points(year)
    sheet = Sheet.find(self.sheet_id)
    player_stats = Player.find(self.player_id).stats_for(year)
    (player_stats.pass_yards * sheet.pass_yard_pts) + (player_stats.pass_tds * sheet.pass_td_pts) + (player_stats.rush_yards * sheet.rush_yard_pts) + (player_stats.interceptions * sheet.int_pts) + (player_stats.rush_tds * sheet.rush_td_pts) + (player_stats.receptions * sheet.rec_pts) + (player_stats.receive_yards * sheet.rec_yard_pts) + (player_stats.receive_tds * sheet.rec_td_pts)
  end

  def adj_proj(year)
    sheet = Sheet.find(self.sheet_id)
    player = Player.find(self.player_id)
    @pos_data = {
      "QB" => {correlation_str: 0.60, avg_proj: sheet.avg_qb_proj},
      "RB" => {correlation_str: 0.48, avg_proj: sheet.avg_rb_proj},
      "WR" => {correlation_str: 0.42, avg_proj: sheet.avg_wr_proj},
      "TE" => {correlation_str: 0.62, avg_proj: sheet.avg_te_proj},
    }
    if player.depth_order == 1
      (@pos_data[player.position][:correlation_str] * (self.total_points(year) - @pos_data[player.position][:avg_proj])) + @pos_data[player.position][:avg_proj]
    else
      0
    end
  end

end
