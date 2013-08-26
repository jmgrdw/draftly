require 'spec_helper'

describe Player do 
	context "creation" do 
		let(:player) { Player.new(full_name: "McArthur Gill", espn_url: "www.test.com", team_id: 1, position: "PG", salary: 9500, position_value: 1) }

		it "should create with valid attributes" do 
			player.save
			expect(Player.count).to eq(1)
		end

		it "should NOT create without a full_name" do
			player.full_name = ""
			player.save
			expect(Player.count).to eq(0)
		end

		it "should NOT create without a team_id" do
		  player.team_id = nil
		  player.save
		  expect(Player.count).to eq(0)
		end

		it "should NOT create without a position" do
		  player.position = ""
		  player.save
		  expect(Player.count).to eq(0)
		end

		it "should NOT create without a salary" do
		  player.salary = nil
		  player.save
		  expect(Player.count).to eq(0)
		end
	end
end