class Ranking < ActiveRecord::Base

  belongs_to :sheet
  belongs_to :player

  # def total_points(year)
  #   sheet = Sheet.find(self.sheet_id)
  #   player_stats = Player.find(self.player_id).stats_for(year)
  #   (player_stats.pass_yards * sheet.pass_yard_pts) + (player_stats.pass_tds * sheet.pass_td_pts) + (player_stats.rush_yards * sheet.rush_yard_pts) + (player_stats.interceptions * sheet.int_pts) + (player_stats.rush_tds * sheet.rush_td_pts) + (player_stats.receptions * sheet.rec_pts) + (player_stats.receive_yards * sheet.rec_yard_pts) + (player_stats.receive_tds * sheet.rec_td_pts)
  # end
  #
  # def self.avg_proj(position, year)
  #   sheet = Sheet.find(self.sheet_id)
  #   players = sheet.ranked_players.where(position: position).where(depth_order: 1)
  #   total = 0
  #   players.each do |player|
  #     ranking = player.rankings.where(sheet_id: self.sheet_id)
  #     total = total + ranking.total_points(year)
  #   end
  #   (total / players.length)
  # end
  #
  # QB_AVG = self.avg_proj("QB", 2016)
  # RB_AVG = self.avg_proj("RB", 2016)
  # WR_AVG = self.avg_proj("WR", 2016)
  # TE_AVG = self.avg_proj("TE", 2016)
  #
  # def adj_proj(position, year)
  #   player = Player.find(self.player_id)
  #   @pos_data = {
  #     "QB" => {correlation_str: 0.60, avg_proj: QB_AVG},
  #     "RB" => {correlation_str: 0.48, avg_proj: RB_AVG},
  #     "WR" => {correlation_str: 0.42, avg_proj: WR_AVG},
  #     "TE" => {correlation_str: 0.62, avg_proj: TE_AVG},
  #   }
  #   if player.depth_order == 1
  #     (@pos_data[player.position][:correlation_str] * (player.total_points(year) - @pos_data[player.position][:avg_proj])) + @pos_data[player.position][:avg_proj]
  #   else
  #     0
  #   end
  # end

end
