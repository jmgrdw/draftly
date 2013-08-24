require 'date'

class League < ActiveRecord::Base
  PAYOUT_PERCENT = 0.90
  
  attr_accessible :fee, :name, :salary_cap, :size, :start_date, :end_date, :league_type, :min_size, :unique_payout_positions, :finalized, :game_ids, :started, :finished
  
  has_many :fantasy_teams
  has_many :games_leagues
  has_many :games, :through => :games_leagues
  
  
  scope :finalized_leagues, where("finalized = ?", true)
  
  
  validates_presence_of :start_date
  validates_presence_of :end_date
  
  def game_ids=(game_ids)
    self.games = Game.find_all_by_id(game_ids)
  end
      
  def positions 
    case league_type
    when 1
      "5 players"
    when 2
      "9 players"
    when 3
      "12 players"
    end
  end
  
  def league_salary_cap
    case league_type
    when 1
      FiveTeam::SALARY_CAP
    when 2
      NineTeam::SALARY_CAP
    when 3
      TwelveTeam::SALARY_CAP
    end
  end
  
  def league_payout_maximum
    # (fantasy_teams.count * fee)*PAYOUT_PERCENT
    size*fee*PAYOUT_PERCENT
  end
    
  def determine_winners
    ordered_rank = fantasy_teams.sort { |a,b| b.current_fantasy_total <=> a.current_fantasy_total }
    winners = ordered_rank.shift(unique_payout_positions)
    winners << ordered_rank.select { |team| team.current_fantasy_total == winners.last.current_fantasy_total }
    winners.flatten!
  end
  
  def available?
    not_full? && not_too_late_to_join_or_update?
  end
  
  def not_full?
    self.fantasy_teams.count < self.size ? true : false
  end
  
  # start day is when league closes, so if it is before Date.today, it is closed, therefore too late
  def not_too_late_to_join_or_update?
    start_date >= Date.today 
  end
  
  def fantasy_teams_count
    fantasy_teams.count
  end
  
    
end
