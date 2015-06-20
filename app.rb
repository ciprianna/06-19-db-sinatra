# Driver
require "sqlite3"
require "sinatra"
require "sinatra/reloader"
require_relative "menu_module.rb"
require_relative "validity_module.rb"
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
require_relative "shoes.rb"
require_relative "location.rb"
require_relative "category.rb"

# Creates the database connection
DATABASE = SQLite3::Database.new("shoe_inventory.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS shoes (id INTEGER PRIMARY KEY, name TEXT NOT NULL, cost INTEGER NOT NULL, color TEXT NOT NULL, category_id INTEGER, location_id INTEGER, location_stock INTEGER);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT);")

# Returns the results as a Hash
DATABASE.results_as_hash = true

################################################################################

get "/home" do
  erb :index
end

get "/current_stock" do
  erb :current_stock
end

get "/quantity_information" do
  erb :quantity_information
end

get "/add_shoe" do
  erb :add_shoe
end

get "/update_product" do
  erb :update_product
end

get "/view_by_cost" do
  erb :view_by_cost
end

get "/location_information" do
  erb :location_information
end

get "/category_information" do
  erb :category_information
end

get "/delete_shoe" do
  erb :delete_shoe
end
