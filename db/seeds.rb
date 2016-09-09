require 'net/http'

# player information api call
def player_data
  uri = URI('https://api.fantasydata.net/nfl/v2/json/Players')
  uri.query = URI.encode_www_form({
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.fantasy_data_api_key
  # Request body
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
  end

  JSON.parse(response.body)
end

# get stats data
def measurables_data(year)
  uri = URI("https://api.fantasydata.net/nfl/v2/json/PlayerSeasonStats/#{year}REG")
  uri.query = URI.encode_www_form({
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.fantasy_data_api_key
  # Request body
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

  JSON.parse(response.body)
end

# get adp_data
def adp_data
  uri = URI('https://api.fantasydata.net/nfl/v2/json/FantasyPlayers')
  uri.query = URI.encode_www_form({
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.fantasy_data_api_key
  # Request body
  request.body = "{body}"

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

  JSON.parse(response.body)
end

def projections
  uri = URI("https://api.fantasydata.net/v3/nfl/projections/json/PlayerSeasonProjectionStats/2016")
uri.query = URI.encode_www_form({
})

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.fantasy_data_api_key
# Request body
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

JSON.parse(response.body)

end


seasons = (2011..2016).to_a.reverse
seasons.each {|season| Season.create!(season: season)}

player_data.each do |player|
  pos = player["Position"]
  pos = "RB" if pos == "FB"

  if pos == "QB" || pos == "RB" || pos == "WR" || pos == "TE"
    Player.create!(
      api_player_id: player["PlayerID"],
      name: player["Name"],
      team: player["Team"],
      position: pos,
      experience: player["Experience"],
      active: player["Active"],
      photo_url: player["PhotoUrl"],
      bye_week: player["ByeWeek"],
      depth_order: player["DepthOrder"],
      draft_round: player["CollegeDraftRound"],
      draft_pick: player["CollegeDraftPick"],
      rotowire_url: "http://www.rotowire.com/football/player.htm?id=#{player['RotoWirePlayerID']}",
      adp: 2000,
      adp_ppr: 2000)
  end
end


year = 2015
season_id = 2
5.times do
  measurables_data(year).each do |measurable|
    pos = measurable["Position"]
    if (pos == "QB" || pos == "RB" || pos == "WR" || pos == "TE") && Player.find_by(api_player_id: measurable["PlayerID"])
      Measurable.create!(
        player_id: Player.find_by(api_player_id: measurable["PlayerID"]).id,
        season_id: season_id,
        games_played: measurable["Played"],
        games_started: measurable["Started"],
        pass_yards: measurable["PassingYards"],
        pass_tds: measurable["PassingTouchdowns"],
        interceptions: measurable["PassingInterceptions"],
        pass_2pt_conv: measurable["TwoPointConversionPasses"],
        rush_yards: measurable["RushingYards"],
        rush_tds: measurable["RushingTouchdowns"],
        rush_2pt_conv: measurable["TwoPointConversionRuns"],
        receptions: measurable["Receptions"],
        receive_yards: measurable["ReceivingYards"],
        receive_tds: measurable["ReceivingTouchdowns"],
        receive_2pt_conv: measurable["TwoPointConversionReceptions"],
        fumbles: measurable["Fumbles"],
        fumbles_lost: measurable["FumblesLost"])
    end
  end
  year -= 1
  season_id += 1
end

projections.each do |measurable|
  pos = measurable["Position"]
  if (pos == "QB" || pos == "RB" || pos == "WR" || pos == "TE") && Player.find_by(api_player_id: measurable["PlayerID"])
    Measurable.create!(
      player_id: Player.find_by(api_player_id: measurable["PlayerID"]).id,
      season_id: 1,
      games_played: measurable["Played"],
      games_started: measurable["Started"],
      pass_yards: measurable["PassingYards"],
      pass_tds: measurable["PassingTouchdowns"],
      interceptions: measurable["PassingInterceptions"],
      pass_2pt_conv: measurable["TwoPointConversionPasses"],
      rush_yards: measurable["RushingYards"],
      rush_tds: measurable["RushingTouchdowns"],
      rush_2pt_conv: measurable["TwoPointConversionRuns"],
      receptions: measurable["Receptions"],
      receive_yards: measurable["ReceivingYards"],
      receive_tds: measurable["ReceivingTouchdowns"],
      receive_2pt_conv: measurable["TwoPointConversionReceptions"],
      fumbles: measurable["Fumbles"],
      fumbles_lost: measurable["FumblesLost"])
  end
end

Player.all.each do |player|
  if player.seasons.where(id: 1).empty?
    Measurable.create!(
      player_id: player.id,
      season_id: 1,
      games_played: 0,
      games_started: 0,
      pass_yards: 0,
      pass_tds: 0,
      interceptions: 0,
      pass_2pt_conv: 0,
      rush_yards: 0,
      rush_tds: 0,
      rush_2pt_conv: 0,
      receptions: 0,
      receive_yards: 0,
      receive_tds: 0,
      receive_2pt_conv: 0,
      fumbles: 0,
      fumbles_lost: 0)
  end
end

adp_data.each do |player|
  if player_to_update = Player.find_by(api_player_id: player["PlayerID"])
    player_to_update.update(adp: player["AverageDraftPosition"])
    player_to_update.update(adp_ppr: player["AverageDraftPositionPPR"])
  end
end

Sheet.create!
