class MeasurablesController < ApplicationController

  def show
    @player = Player.find(params["player_id"])
    @stats = @player.player_stats.sort_by {|m| m.season_id}
    render partial: "measurables/show", layout: false
  end

end
