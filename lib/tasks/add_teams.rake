require 'addTeams'

namespace :db do 
  desc "add teams and divisions"
  task :add_teams => :environment do 
    AddTeams.populate_teams
  end
end