# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090822210003) do

  create_table "age_groups", :force => true do |t|
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "age_groups", ["position"], :name => "index_age_groups_on_position"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "rational_options", :force => true do |t|
    t.integer  "numerator",   :null => false
    t.integer  "denominator", :null => false
    t.decimal  "quotient",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_groups", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.string   "group_name"
    t.integer  "age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_groups", ["user_id", "group_name"], :name => "index_survey_groups_on_user_id_and_group_name", :unique => true

  create_table "surveys", :force => true do |t|
    t.decimal  "r_star"
    t.decimal  "fp"
    t.decimal  "ne"
    t.decimal  "fl"
    t.decimal  "fi"
    t.decimal  "fc"
    t.integer  "l"
    t.integer  "n"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            :limit => 8
    t.integer  "survey_group_id"
  end

  add_index "surveys", ["slug"], :name => "index_surveys_on_slug", :unique => true
  add_index "surveys", ["survey_group_id"], :name => "index_surveys_on_survey_group_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "token",              :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.boolean  "admin",                             :default => false, :null => false
    t.string   "identity_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["identity_url"], :name => "index_users_on_identity_url", :unique => true
  add_index "users", ["token"], :name => "index_users_on_token"

end
