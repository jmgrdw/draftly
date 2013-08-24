require 'nokogiri'
require 'open-uri'

module AddPlayers
  def self.player_names_and_urls
    @teams = Team.all
    @teams.each do |team|
      url = "http://espn.go.com/nba/team/roster/_/name/#{team.abbreviation}/#{team.espn_long_name}"
      doc = Nokogiri::HTML(open(url),nil,'ISO-8859-1')
      r_table = doc.at_css('table.tablehead')
      r_rows = r_table.css("tr")
      r_rows.each do |row|
        if (row['class'].include?('oddrow') || row['class'].include?('evenrow'))
          player_name = row.css('td')[1].text # ESPN player name
          player_url = row.css('td')[1].xpath('.//a')[0].attributes()["href"].value() # ESPN player url
          # player_height = row.css('td')[4].text
          player_position = row.css('td')[2].text
          # player_weight = row.css('td')[5].text
          if player_name =~ /\ANen/
            player_name = "Nene"
            player_url = "http://espn.go.com/nba/player/_/id/1713/nene"
            # player_height = row.css('td')[4].text
            player_position = row.css('td')[2].text
            # player_weight = row.css('td')[5].text
          end
          player = team.players.find_or_create_by_full_name(:full_name => player_name)
          player.update_attributes(:team_id => team.id, :espn_url => player_url, :position => player_position)
          p "saved stats for... #{player.full_name}"
        end
      end
    end 
  end
end