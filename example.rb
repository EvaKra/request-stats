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
  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.string   "name"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
  end
  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
  end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
class Comment < ApplicationRecord
  belongs_to :post
end
class Post < ApplicationRecord
  has_many :comments
end

# Try everything out!
post = Post.new
post.title = "We got a puppy!"
post.body = "Her name is Chai."
post.save
post.comments.create(content: "Awww.")
post.comments.create(content: "So cute!")
Post.find_each do |post|
  p post.comments
end