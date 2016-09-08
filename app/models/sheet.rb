class Sheet < ActiveRecord::Base
  has_many :rankings
  has_many :ranked_players, through: :rankings, source: :player

  after_initialize :init
  after_save :create_rankings


  protected
  def init
    self.url_parameter ||= generate_url_parameter
    self.pass_yard_pts ||= 0.04
    self.pass_td_pts ||= 6
    self.int_pts ||= -2
    self.rush_yard_pts ||= 0.1
    self.rush_td_pts = 6
    self.rec_pts = 1
    self.rec_yard_pts = 0.1
    self.rec_td_pts ||= 6
  end

  def generate_url_parameter
    chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a
    param = chars.sample(10).join
    while Sheet.find_by(url_parameter: param)
      param = chars.sample(10).join
    end
    param
  end

  def create_rankings
    Player.all.each {|player| Ranking.create!(player_id: player.id, sheet_id: self.id)}
  end

  # def ordered_players
  #   self.rankings.sort do |a,b|
  #     player_a = Player.find(a.player_id)
  #     player_b = Player.find(b.player_id)
  #     [player_a.adp_ppr, b.adj_proj(player_b.position, 2016)] <=> [player_b.adp_ppr, a.adj_proj(player_a.position, 2016)]
  #   end
  # end
  #
  # def set_ranks
  #   ranked_players.each_with_index do |player, index|
  #     player.update(player_rank: index + 1)
  #   end
  # end

end
