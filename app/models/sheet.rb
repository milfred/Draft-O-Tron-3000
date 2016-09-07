class Sheet < ActiveRecord::Base
  has_many :rankings
  has_many :ranked_players, through: :rankings, source: :player

  after_initialize :init

  def init
    self.url_param ||= generate_url_parameter
    self.pass_yard_pts ||= 0.04
    self.pass_td_pts ||= 6
    self.int_pts ||= -2
    self.run_yard_pts ||= 0.1
    self.run_td_pts = 6
    self.rec_pts = 1
    self.rec_yard_pts = 0.1
    self.rec_td_pts ||= 6
  end

  def generate_url_parameter
    chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a
    param = chars.sample(10).join
    while Sheet.find_by(url_param: param)
      param = chars.sample(10).join
    end
    param
  end

end
