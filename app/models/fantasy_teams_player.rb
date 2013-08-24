class FantasyTeamsPlayer < ActiveRecord::Base
  attr_accessible :fantasy_team_id, :player_id
  
  belongs_to :fantasy_team
  belongs_to :player
end
