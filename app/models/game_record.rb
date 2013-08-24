class GameRecord < ActiveRecord::Base
  attr_accessible :blocks, :espn_id, :game_id, :minutes, :player_id, :points, :rebounds, :steals, :turnovers, :played, :assists, :date, :opponent_id
  
  belongs_to :player
  belongs_to :game
  
end
