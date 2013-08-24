require 'addPlayers'

namespace :db do 
  desc "add players to teams"
  task :add_players => :environment do
    AddPlayers.player_names_and_urls
  end
end