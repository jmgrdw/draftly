require 'nokogiri'
require 'open-uri'
require 'date'

module NextNbaGames
  
  # date_string comes in as "20131128" YYYMMDD
  def self.get_games_from_date(date_string)
    
    game_date = date_object_from_date_string(date_string)
    espn_url = espn_url_from_date(date_string)
    doc = Nokogiri::HTML(open(espn_url), nil, 'ISO-8859-1')
    matchups = doc.css('.mod-scorebox')
    matchups.each do |matchup|
      game_time_string = matchup.at_css('.game-status p').text()
      game_time = game_time_object_from_string(game_time_string, game_date)
      away_team, home_team = teams_from_espn_div(matchup.css('.team-name'))
      espn_id = box_score_id_from_matchup_div(matchup)
      game = Game.new(:espn_id => espn_id, :home_team_id => home_team.id, :away_team_id => away_team.id, :date => game_date, :game_time => game_time)
      game.save
    end
    p "added games for #{date_string}"
  end
  
  def self.box_score_id_from_matchup_div(matchup)
    espn_id = matchup.at_css('.game-status p').attributes()['id'].value().split('-')[0]
  end
  
  def self.teams_from_espn_div(espn_divs)
    away_team_div, home_team_div = espn_divs[0], espn_divs[1]
    away_team_text = away_team_div.xpath('.//a').text()
    home_team_text = home_team_div.xpath('.//a').text()
    away_team, home_team = Team.find_by_short_name(away_team_text), Team.find_by_short_name(home_team_text)    
    [away_team, home_team]
  end
  
  def self.game_time_object_from_string(game_time_string, game_date)
    initial_hour = game_time_string.split(':')[0].to_i
    minutes = game_time_string.split(' ')[0].split(':')[1]
    hour = initial_hour < 12 ? initial_hour + 12 : initial_hour
    game_time = Time.new(game_date.year, game_date.month, game_date.day, hour, minutes, 0)
    
  end
  
  # espn url looks like "http://scores.espn.go.com/nba/scoreboard?date=20131029"
  def self.espn_url_from_date(date_string)
    url = "http://scores.espn.go.com/nba/scoreboard?date=" + date_string
  end
  
  def self.date_object_from_date_string(date_string)
    year, month, day = date_string[0..3].to_i, date_string[4..5].to_i, date_string[6..7].to_i
    game_date = Date.new(year,month,day)
  end
  
end