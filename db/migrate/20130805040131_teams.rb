class Teams < ActiveRecord::Migration
  
  def change
    create_table :teams do |t|
      
      t.string :full_name
      t.string :abbreviation
      t.string :espn_long_name
      t.string :url
      
      t.string :city
      t.string :short_name      
      
      t.timestamps
    end
    
  end
  
end
