namespace :db do 
  desc "add salaries to each player"
  task :populate_salaries => :environment do 
  	possible_salaries = [3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500]
    Player.all.each do |player|
    	player.salary = possible_salaries.sample
    	player.save
    	p "#{player.name}'s salary is #{player.salary}"
    end
  end
end