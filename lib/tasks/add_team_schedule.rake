require 'addEmptyGames'

namespace :db do 
  desc "add schedules for teams"
  task :add_games => :environment do 
    # @team = Team.first
    # EspnTeamScheduleScraper.get_team_schedule_for_team(@team)  
    @teams = Team.all
    @teams.each do |team|
      EspnTeamScheduleScraper.get_team_schedule_for_team(team)  
    end
  end
end