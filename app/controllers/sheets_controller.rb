class SheetsController < ApplicationController

  def search
    @sheet = Sheet.find(params[:id])
    @results = @sheet.search(params[:search])
    render json: @results
  end

  def show
    @sheet = Sheet.find(params[:id])
    if params[:id] == @sheet.url_parameter
      @players = @sheet.ranked_players
      render "show"
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def create
    @sheet = Sheet.new
    if @sheet
      @sheet.save
      redirect_to "/sheets/#{@sheet.url_parameter}"
    end
  end

  def update
    sheet = Sheet.find(params[:id])
    sheet.update!(sheet_params)
    p params

    render nothing: true
  end



  private

  def sheet_params
    params.require(:sheet).permit(:pass_yard_pts, :pass_td_pts, :int_pts, :rush_yard_pts, :rush_td_pts, :rec_pts, :rec_yard_pts, :rec_td_pts)
  end

end
