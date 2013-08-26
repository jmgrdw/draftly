namespace :db do 
  desc "add salaries to each player"
  task :populate_salaries => :environment do 
  	possible_salaries = (3000..9500).to_a
    Player.all.each do |player|
    	player.salary = possible_salaries.sample
    	player.save
    	p "#{player.name}'s salary is #{player.salary}"
    end
  end
end