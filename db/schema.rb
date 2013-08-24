# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130822004106) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "balance",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "current_stats", :force => true do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.integer  "minutes",    :default => 0
    t.integer  "points",     :default => 0
    t.integer  "rebounds",   :default => 0
    t.integer  "assists",    :default => 0
    t.integer  "blocks",     :default => 0
    t.integer  "steals",     :default => 0
    t.integer  "turnovers",  :default => 0
    t.boolean  "finished",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "fantasy_teams", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "league_id"
    t.string   "type"
  end

  create_table "fantasy_teams_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "fantasy_team_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_records", :force => true do |t|
    t.string   "espn_id"
    t.integer  "player_id"
    t.integer  "game_id"
    t.integer  "opponent_id"
    t.integer  "minutes"
    t.date     "date"
    t.integer  "points"
    t.integer  "rebounds"
    t.integer  "assists"
    t.integer  "blocks"
    t.integer  "steals"
    t.integer  "turnovers"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "played"
  end

  create_table "games", :force => true do |t|
    t.string   "espn_id"
    t.date     "date"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.time     "game_time"
  end

  create_table "games_leagues", :force => true do |t|
    t.integer  "game_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.integer  "fee"
    t.datetime "start_date"
    t.integer  "salary_cap"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "league_type"
    t.integer  "min_size"
    t.integer  "unique_payout_positions"
    t.date     "end_date"
    t.boolean  "finalized",               :default => false
    t.boolean  "started",                 :default => false
    t.boolean  "finished",                :default => false
  end

  create_table "paypal_logins", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "full_name"
    t.string   "espn_url"
    t.integer  "team_id"
    t.string   "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "salary"
    t.integer  "position_value"
  end

  create_table "products", :force => true do |t|
    t.integer  "amount"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "full_name"
    t.string   "abbreviation"
    t.string   "espn_long_name"
    t.string   "url"
    t.string   "city"
    t.string   "short_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "playing_today"
  end

  create_table "transaction_histories", :force => true do |t|
    t.integer  "value"
    t.integer  "fantasy_team_id"
    t.integer  "account_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
