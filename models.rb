# Instead of loading all of Rails, load the
# particular Rails dependencies we need
require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)


# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table "customers", force: :cascade do |t|
    t.text     "name"
    t.integer  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hourly_stats", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "time"
    t.integer  "request_count"
    t.integer  "invalid_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_hourly_stats_on_customer_id"
  end

  create_table "ip_blacklists", force: :cascade do |t|
    t.string  "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ua_blacklists", force: :cascade do |t|
    t.string  "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end


# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Customer < ApplicationRecord
    has_many :hourly_stats
end

class Hourly_stat < ApplicationRecord
    belongs_to :customers
end

class Ip_blacklist < ApplicationRecord
    
end

class Ua_blacklist < ApplicationRecord
    
end
