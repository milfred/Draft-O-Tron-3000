class PlayersController < ApplicationController

  def search
    @results = Player.search(params[:search])
    render json: @results
  end

end
