class Ranking < ActiveRecord::Base
  belongs_to :sheet
  belongs_to :player

  default_scope { order('player_rank') }

  after_initialize :init

  protected
  def init
    self.status ||= 0
  end
end
