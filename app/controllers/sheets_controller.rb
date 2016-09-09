class SheetsController < ApplicationController

  def show
    @sheet = Sheet.find_by(url_parameter: params[:param])
    @players = @sheet.ranked_players.first(300).sort do |a,b|
      a.player_rank(@sheet) <=> b.player_rank(@sheet)
    end
    render "show"
  end

  def update
    if request.xhr
      
    else

    end
  end

end
