require 'spec_helper'

describe Player do 
	context "creation" do 
		it "should create with valid attributes" do 
			Player.create(full_name: "McArthur Gill", espn_url: "www.test.com", team_id: 1, position: "PG", salary: 9500, position_value: 1)
			expect(Player.count).to eq(1)
		end
	end
end