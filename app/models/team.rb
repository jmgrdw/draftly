class Team < ActiveRecord::Base
  attr_accessible :full_name, :city, :abbreviation, :url, :espn_long_name, :short_name, :playing_today

  validates_presence_of :full_name, :city, :abbreviation, :url, :espn_long_name, :short_name
  
  has_many :players
  
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
  
  accepts_nested_attributes_for :players
  
  scope :playing_today, where('playing_today = ?', true)
  
  def games
    home_games + away_games
  end
  
  def name
    full_name
  end
end