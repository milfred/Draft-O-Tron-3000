class SheetsController < ApplicationController

  def show
    @sheet = Sheet.find_by(url_parameter: params[:param])
    @players = @sheet.ranked_players.sort {|a,b| a.player_rank(@sheet) <=> b.player_rank(@sheet)}.first(300)
    render "show"
  end

  def update
    if request.xhr
      
    else

    end
  end

end
