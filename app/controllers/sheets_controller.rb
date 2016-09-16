class SheetsController < ApplicationController

  def show
    @sheet = Sheet.find(params[:id])
    @players = @sheet.rankings.map {|ranking| Player.find(ranking.player_id)}
    render "show"
  end

  def update
    sheet = Sheet.find(params[:id])
    sheet.update!(sheet_params)

    render nothing: true
  end

  def create
    @sheet = Sheet.new
    if @sheet
      @sheet.save
      redirect_to "/sheets/#{@sheet.url_parameter}"
    end
  end

  private

  def sheet_params
    params.require(:sheet).permit(:pass_yard_pts, :pass_td_pts, :int_pts, :rush_yard_pts, :rush_td_pts, :rec_pts, :rec_yard_pts, :rec_td_pts)
  end

end
