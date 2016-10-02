class RankingsController < ApplicationController

  def update
    ranking = Ranking.find(params[:id])
    ranking.update!(ranking_params)
    render nothing: true
  end

  private

  def ranking_params
    params.permit(:player_rank, :status)
  end

end
