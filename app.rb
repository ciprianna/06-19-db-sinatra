# Driver
require "sqlite3"
require "sinatra"
require "sinatra/reloader"
require "pry"
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

get "/save_shoe_update" do
  shoe_to_change = Shoe.find(params["shoe_id"])
  shoe_to_change.name = params["name"]
  shoe_to_change.cost = params["cost"]
  shoe_to_change.color = params["color"]
  shoe_to_change.category_id = params["category_id"]
  shoe_to_change.location_id = params["location_id"]

  if shoe_to_change.save_valid
    erb :success
  else
    erb :failure
  end
end

get "/view_by_cost" do
  erb :view_by_cost
end

get "/cost_category" do
  erb :cost_category
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

get "/view_quantities" do
  erb :view_quantities
end

get "/low_quantities" do
  erb :low_quantities
end

get "/update_quantities" do
  erb :update_quantities
end

get "/save_quantity_update" do
  # Creates new Shoe Object
  shoe_to_update = Shoe.find(params["shoe_id"].to_i)

  # Updates shoe quantity and routes to either success or failure erb
  if shoe_to_update.update_quantity(params["new_quantity"].to_i)
    erb :success
  else
    erb :failure
  end
end

get "/save_new_shoe" do
  # Creates new Shoe Object from form information
  @shoe_to_add = Shoe.new({"name" => params["name"], "cost" => params["cost"].to_i, "color" => params["color"], "category_id" => params["category_id"].to_i, "location_id" => params["location_id"].to_i, "location_stock" => params["location_stock"].to_i})

  # Runs add_to_database method and leads to success or failure erbs
  if @shoe_to_add.add_to_database
    erb :success
  else
    erb :failure
  end
end
