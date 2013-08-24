require 'date'

class Game < ActiveRecord::Base
  attr_accessible :away_team_id, :date, :espn_id, :home_team_id, :game_time
  
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  
  has_many :game_records
  has_many :players, :through => :game_records
  
  has_many :games_leagues
  has_many :leagues, :through => :games_leagues
  
  has_many :current_stats
  
  scope :today, where('date = ?', Date.today)
  
  def self.find_within_date_range(start_date, end_date)
    games = Game.where("date >= ? AND date <= ?", start_date.to_date, end_date.to_date)
  end
    
end
