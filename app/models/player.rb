class Player < ActiveRecord::Base
  attr_accessible :full_name, :espn_url, :position, :team_id, :salary, :position_value
  validates_presence_of :full_name, :team_id, :position, :salary
  
  belongs_to :team
  
  has_one :current_stat
  has_many :game_records
  has_many :games, :through => :game_records
  
  has_many :fantasy_teams_players
  has_many :fantasy_teams, :through => :fantasy_teams_players
  
  scope :playing_today_by_position, lambda { |input| select('players.*').joins(:team).where('players.position_value = ? and teams.playing_today = ?', input, true) }
    
  def name
    full_name
  end
  
  # pretty sure we don't use this anymore because we get players through leagues' games -> home/away teams -> players
  def self.playing_today_all
    Player.joins(:team).where('teams.playing_today = ?', true)
  end
  
  def player_show
    "(#{self.team.abbreviation.upcase}) #{full_name}"
  end
  
  def current_fantasy_total
    current_stat.total
  end
    
end
