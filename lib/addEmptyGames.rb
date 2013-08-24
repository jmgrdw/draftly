require 'nokogiri'
require 'open-uri'
require 'date'

module EspnTeamScheduleScraper
  
  def self.get_team_schedule_for_team(team)
    
    team_schedule_url = team_schedule_url_from_team(team)
    puts "fetching schedule for: #{team.full_name}"
    doc = Nokogiri::HTML(open(team_schedule_url),nil,'ISO-8859-1')
    stats_table = doc.css('table.tablehead')
    all_rows = stats_table.css('tr.oddrow') + stats_table.css('tr.evenrow')
    game_rows = strip_non_games_from_rows(all_rows)
    game_rows.each do |game_row|
      game_stats = stats_from_row(game_row)
      game = Game.find_by_espn_id(game_stats[:espn_id]) || Game.new(:espn_id => game_stats[:espn_id])
      game_stats[:home_team_id], game_stats[:away_team_id] = assign_home_and_away_from_game_stats(game_stats, team.id)
      game.update_attributes(game_stats)
    end
  end
  
  def self.assign_home_and_away_from_game_stats(game_stats_hash, current_team_id)
    home_boolean, opponent_id = game_stats_hash.delete(:home_boolean), game_stats_hash.delete(:opponent_id)
    home_boolean ? (home, away = current_team_id, opponent_id) : (home, away = opponent_id, current_team_id)
  end
    
  def self.stats_from_row(game_row)
    stats = game_row.css('td').collect(&:text)
    {
      :date => game_date_from_stats(stats[0]),
      :opponent_id => opponent_id_from_stats(game_row.css('td')[1]),
      :home_boolean => home_boolean_from_stats(stats[1]),
      :espn_id => espn_box_score_id_from_stats(game_row.css('td')[2])
    }
  end
  
  def self.espn_box_score_id_from_stats(score_node)
    if score_node.xpath('.//a')[0]
      espn_id = score_node.xpath('.//a')[0].attributes()['href'].value().split("=")[1]
    else
      espn_id = "MISSING"
    end
  end
  
  def self.home_boolean_from_stats(opponent_string)
    opponent_string[0..1] == "vs" ? true : false
  end
  
  # splitting ESPN link of opponent ... something like espn.com/nba/something/{ABR}/something/{TEAM_NAME}
  def self.opponent_id_from_stats(opponent_node)
    opponent_abbreviation = opponent_node.xpath('.//a')[0].attributes()['href'].value().split('name/')[1].split('/')[0]
    # opponent_abbreviation == "gs" ? opponent_abbreviation = "gs" : opponent_abbreviation
    opponent_id = Team.find_by_abbreviation(opponent_abbreviation).id
  end
  
  # comes in as "Tue, 12/24" etc.
  def self.game_date_from_stats(date_string)    
    month_string, day = date_string.split(", ")[1].split(" ")
    month = month_number_from_string(month_string)
    month > 8 ? year = 2012 : year = 2013
    game_date = Date.new(year, month, day.to_i)
  end
  
  def self.team_schedule_url_from_team(team)
    schedule_url = "http://espn.go.com/nba/team/schedule/_/name/" + team.abbreviation + "/seasontype/2/" + team.espn_long_name
  end
  
  def self.strip_non_games_from_rows(all_rows)
    team_regex = /team/
    game_rows = all_rows.find_all { |row| row.attributes()['class'].value() =~ team_regex }
  end
  
  def self.month_number_from_string(month_string)
    month_hash = { "Oct" => 10, "Nov" => 11, "Dec" => 12, "Jan" => 1, "Feb" => 2, "Mar" => 3, "Apr" => 4, "May" => 5 }
    month_hash[month_string] ? month_hash[month_string] : 0
  end
  
end