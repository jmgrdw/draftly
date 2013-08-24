require 'nokogiri'
require 'open-uri'
require 'date'

module EspnPlayerStats
  
  def self.get_season_stats_for_player(player)
    player_url = player.espn_url
    gamelog_url = gamelog_url_from_player_url(player_url)
        
    doc = Nokogiri::HTML(open(gamelog_url),nil,'ISO-8859-1')
    
    stats_table = doc.css('table.tablehead')
    header = doc.css('table.tablehead').at_css('tr.stathead').text()
    if header.include? "2012-2013"
      all_rows = stats_table.css('tr.oddrow') + stats_table.css('tr.evenrow')
      game_rows = strip_non_games_from_rows(all_rows)
    
      game_rows.each do |game_row|
        player_stats_from_game = stats_from_row(game_row)
        espn_id = player_stats_from_game[:espn_id]
        # game = Game.find_by_espn_id(espn_id) || Game.create(:espn_id => espn_id)
        game = Game.find_by_espn_id(espn_id)
        unless game.nil?
          player_stats_from_game[:game_id] = game.id
          player_stats_from_game[:played] = played_boolean_from_player_minutes(player_stats_from_game[:minutes])
          player_game_record = player.game_records.find_by_espn_id(espn_id) || GameRecord.new(:player_id => player.id, :espn_id => espn_id)  
          player_game_record.update_attributes(player_stats_from_game)
        end
      end
    end
    
  end
  
  def self.stats_from_row(game_row)
    
    stats = game_row.css('td').collect(&:text)
    {
      :date => game_date_from_stats(stats[0]),
      :opponent_id => opponent_id_from_stats(stats[1]),
      # :home => home_boolean_from_stats(stats[1]),
      :espn_id => espn_box_score_id_from_stats(game_row.css('td')[2]),
      # :win => win_boolean_from_stats(stats[2]),
      :minutes => stats[3],
      # :fga => makes_or_attempts_from_stats(stats[4], 0),
      # :fgm => makes_or_attempts_from_stats(stats[4], 1),
      # :fgpercent => stats[5],
      # :threepm => makes_or_attempts_from_stats(stats[6], 0),
      # :threepa => makes_or_attempts_from_stats(stats[6], 1),
      # :threepercent => stats[7],
      # :ftm => makes_or_attempts_from_stats(stats[8], 0),
      # :fta => makes_or_attempts_from_stats(stats[8], 1),
      # :ftpercent => stats[9],
      :rebounds => stats[10],
      :assists => stats[11],
      :blocks => stats[12],
      :steals => stats[13],
      # :fouls => stats[14],
      :turnovers => stats[15],
      :points => stats[16]
    }  
  end
  
  def self.played_boolean_from_player_minutes(minutes)
    (minutes == "0" || minutes == 0) ? false : true
  end
  
  # score_node comes in as '/nba/boxscore?id=400278950' and returns id #
  def self.espn_box_score_id_from_stats(score_node)
    espn_id = score_node.xpath('.//a')[0].attributes()['href'].value().split("=")[1]
  end
  
  def self.opponent_id_from_stats(opponent_string)
    opponent_string[0..1].downcase == "vs" ? team_string = opponent_string[2..4].downcase : team_string = opponent_string.split("@ ")[-1].downcase
    parsed_team_string = parse_espn_team_abbreviation(team_string)
    team_id = Team.find_by_abbreviation(parsed_team_string).id
  end
  
  def self.parse_espn_team_abbreviation(team_abbreviation)
    team_abbreviation[-2..-1] == "no" ? (return team_string = "no") : team_string = team_abbreviation
    team_abbreviation == "gs" ? (return team_string = "gs") : team_string = team_abbreviation
    team_abbreviation == "uta" ? (return team_string = "utah") : team_string = team_abbreviation
    return team_string
  end
  
  # comes in Makes-Attempts => 6-15, 0-0, 1-3, etc.
  # split_value => which part of the shot chart, 0 => Makes, 1 => attempts
  def self.makes_or_attempts_from_stats(shots_string, split_value=0)
    shots = shots_string.split('-')[split_value]
  end
  
  def self.win_boolean_from_stats(game_score_string)
    win_loss = game_score_string[0]
    win_loss == "W" ? result = true : result = false
    result
  end
  
  # comes in as (Wed/Thu) 1/1, Tue 12/24, etc.
  def self.game_date_from_stats(date_string)    
    month, day = date_string.split(" ")[1].split("/").collect(&:to_i)
    month.to_i > 8 ? year = 2012 : year = 2013
    game_date = Date.new(year, month, day)
  end
  
  def self.home_boolean_from_stats(opponent_string)
    opponent_string[0..1].downcase == "vs" ? true : false
  end
  
  def self.team_abbreviation_from_stats(opponent_string)
    opponent_string[0..1].downcase == "vs" ? team_string = opponent_string[2..4].downcase : team_string = opponent_string.split("@ ")[-1].downcase
  end
  
  def self.gamelog_url_from_player_url(player_url)
    gamelog_url = "http://espn.go.com/nba/player/gamelog/" + player_url.split("player/")[1]
  end
  
  def self.strip_non_games_from_rows(all_rows)
    team_regex = /team/
    game_rows = all_rows.find_all { |row| row.attributes()['class'].value() =~ team_regex }
  end
  
end