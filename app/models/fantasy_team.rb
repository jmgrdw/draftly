class FantasyTeam < ActiveRecord::Base
  
  before_save :check_league_availability
  
  attr_accessible :name, :user_id, :player_ids, :league_id


  has_many :transaction_histories
  
  has_many :fantasy_teams_players
  has_many :players, :through => :fantasy_teams_players
  belongs_to :user
  belongs_to :league
  
  def self.current_fantasy_teams
    FantasyTeam.joins(:league).where('leagues.started = ? AND leagues.finished = ?', true, false)
  end
  
  def self.upcoming_fantasy_teams
    FantasyTeam.joins(:league).where('leagues.started = ?', false)
  end
  
  def self.build_fantasy_team_from_league(league_type, params = {})
    case league_type
    when 1
      FiveTeam.new(params)
    when 2
      NineTeam.new(params)
    when 3
      TwelveTeam.new(params)
    end
  end
  
  def current_fantasy_total
    players.inject(0) { |sum, player| sum += player.current_stat.total if player.current_stat }
  end
  
  def player_ids=(player_ids)
    self.players = Player.find_all_by_id(player_ids)
  end
  
  def team_salary
    players.inject(0) { |sum, p| sum += p.salary }
  end
  
  def check_league_availability
    league = League.find_by_id(self.league_id)
    return league.available?
  end
  
  def self.inherited(child)
    child.instance_eval do 
      alias :original_model_name :model_name
      def model_name
        FantasyTeam.model_name
      end
    end
    super
  end
      
end
