class AddEndDateToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :end_date, :date
  end
end
