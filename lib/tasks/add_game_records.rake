require 'addGameRecords'

namespace :db do 
  desc "add all games for player(s) from ESPN gamelog"
  
  task :add_game_records => :environment do
    @teams = Team.all
    @teams.each do |team|
      team.players.each do |player|
        EspnPlayerStats.get_season_stats_for_player(player)
        puts "got dem season stats for: #{player.full_name }"
      end
    end
  end
end