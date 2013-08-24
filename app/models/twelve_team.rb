class TwelveTeam < FantasyTeam
  
  FANTASY_TEAM_POSITIONS = %w(C C PF PF PG PG PG SF SF SF SG SG)
  ORDERED_POSITIONS_LIST = %w(PG PG PG SG SG SF SF SF PF PF C)
  SALARY_CAP = 75000
  
  validates :players, length: { is: 12 }
  before_save :validate_positions
  
  def available_positions
    positions = FANTASY_TEAM_POSITIONS.join(", ")
  end
  
  def salary_cap
    SALARY_CAP
  end
  
  def positions_list
    ORDERED_POSITIONS_LIST
  end
  
  private
    def validate_positions
      players.map(&:position).sort{ |a,b| a <=> b } == FANTASY_TEAM_POSITIONS ? true : false
    end
    
    def check_salary_cap
      players.inject(0) { |sum, player| sum += player.salary } <= SALARY_CAP
    end
end