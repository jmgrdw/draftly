require 'addGamesByDate'

namespace :db do
  desc "add games by dates"
  task :add_games_for_dates => :environment do
    date_strings = %w(20131029 20131030 20131031 20131101 20131102 20131103 20131104)
    date_strings.each do |date|
      NextNbaGames.get_games_from_date(date)
    end
  end
end

# task :add_games_for_dates, [:date_string, :yeah_you] => :environment do |t, args|
#   NextNbaGames.get_games_from_date(args[:date_string])
# end