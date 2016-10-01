class Sheet < ActiveRecord::Base
  has_many :rankings
  has_many :ranked_players, through: :rankings, source: :player

  after_initialize :init
  after_create :create_rankings, :create_slug!
  after_save :update_avg_projs!

  extend FriendlyId
  friendly_id :url_parameter, use: :finders

  def avg_proj(player_position, year)
    players = self.ranked_players.where(position: player_position).where(depth_order: 1)
    total = 0
    players.each do |player|
      total = total + player.total_points(self, year)
    end
    (total / players.length)
  end

  def search(search_term)
    self.ranked_players.where('lower(name) LIKE ?', "%#{search_term.downcase}%").where.not(team: nil)
  end

  protected
  def init
    self.url_parameter ||= generate_url_parameter
    self.pass_yard_pts ||= 0.04
    self.pass_td_pts ||= 6
    self.int_pts ||= -2
    self.rush_yard_pts ||= 0.1
    self.rush_td_pts ||= 6
    self.rec_pts ||= 1
    self.rec_yard_pts ||= 0.1
    self.rec_td_pts ||= 6
  end

  def update_avg_projs!
      self.update_column(:avg_qb_proj, self.avg_proj("QB", 2016))
      self.update_column(:avg_rb_proj, self.avg_proj("RB", 2016))
      self.update_column(:avg_wr_proj, self.avg_proj("WR", 2016))
      self.update_column(:avg_te_proj, self.avg_proj("TE", 2016))
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
    players = Player.all.sort {|a,b| a.adp_ppr <=> b.adp_ppr}
    players.first(300).each_with_index {|player, index| Ranking.create!(player_id: player.id, sheet_id: self.id, player_rank: index + 1)}
  end

  def create_slug!
    self.update_column(:slug, self.url_parameter)
  end

end
