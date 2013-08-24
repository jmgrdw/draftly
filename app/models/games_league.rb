class GamesLeague < ActiveRecord::Base
  attr_accessible :game_id, :league_id
  
  belongs_to :game
  belongs_to :league
end
