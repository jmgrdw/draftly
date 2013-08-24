class FiveTeam < FantasyTeam
  
  FANTASY_TEAM_POSITIONS = %w(C PF PG SF SG)
  ORDERED_POSITIONS_LIST = %w(PG SG SF PF C)
  
  SALARY_CAP = 35000
    
  validates :players, length: { is: 5 }  
  before_save :validate_positions, :check_salary_cap
  
  def available_positions
    positions = FANTASY_TEAM_POSITIONS.join(", ")
  end
  
  def positions_list
    ORDERED_POSITIONS_LIST
  end
  
  def salary_cap
    SALARY_CAP
  end
    
  private
    def validate_positions
      players.map(&:position).sort{ |a,b| a <=> b } == FANTASY_TEAM_POSITIONS ? true : false
    end
    
    def check_salary_cap
      players.inject(0) { |sum, player| sum += player.salary } <= SALARY_CAP
    end
end