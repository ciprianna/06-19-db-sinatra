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
# START OF UX
################################################################################
require_relative "controllers/shoes.rb"
get "/home" do
  erb :"general/index"
end

get "/quantity_information" do
  erb :"general/quantity_information"
end

get "/view_by_cost" do
  erb :"general/view_by_cost"
end

get "/cost_category" do
  erb :"general/cost_category"
end

get "/location_information" do
  erb :"locations/location_information"
end

get "/category_information" do
  erb :"categories/category_information"
end

get "/delete_shoe" do
  erb :"shoes/delete_shoe"
end

get "/really_delete_shoe"do
  shoe_to_delete = Shoe.find(params["shoe_id"].to_i)

  if shoe_to_delete.delete
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/view_quantities" do
  erb :"general/view_quantities"
end

get "/low_quantities" do
  erb :"general/low_quantities"
end

get "/update_quantities" do
  erb :"general/update_quantities"
end

get "/save_quantity_update" do
  # Creates new Shoe Object
  shoe_to_update = Shoe.find(params["shoe_id"].to_i)

  # Updates shoe quantity and routes to either success or failure erb
  if shoe_to_update.update_quantity(params["new_quantity"].to_i)
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/all_locations" do
  erb :"locations/all_locations"
end

get "/all_categories" do
  erb :"categories/all_categories"
end

get "/shoes_at_a_location" do
  erb :"locations/shoes_at_a_location"
end

get "/save_view_by_location" do
  @location_to_view = Location.find(params["location_id"])
  erb :"locations/save_view_by_location"
end

get "/shoes_in_a_category" do
  erb :"categories/shoes_in_a_category"
end

get "/save_view_by_category" do
  @category_to_view = Category.find(params["category_id"])
  erb :"categories/save_view_by_category"
end

get "/change_location_name" do
  erb :"locations/change_location_name"
end

get "/save_location_name" do
  location_to_change = Location.find(params["id"])
  location_to_change.name = params["new_name"]

  if location_to_change.save_valid
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/change_category_name" do
  erb :"categories/change_category_name"
end

get "/save_category_name" do
  category_to_change = Category.find(params["id"])
  category_to_change.name = params["new_name"]

  if category_to_change.save_valid
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/add_location" do
  erb :"locations/add_location"
end

get "/save_new_location" do
  location_to_add = Location.new({"name" => params["name"]})

  if location_to_add.add_to_database
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/add_category" do
  erb :"categories/add_category"
end

get "/save_new_category" do
  category_to_add = Category.new({"name" => params["name"]})

  if category_to_add.add_to_database
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

get "/delete_location" do
  erb :"locations/delete_location"
end

get "/really_delete_location" do
  @location_to_delete = Location.find(params["id"])

  if @location_to_delete.delete_location
    erb :"general/success"
  else
    @error = true
    erb :"locations/delete_location"
  end
end

get "/delete_category" do
  erb :"categories/delete_category"
end

get "/really_delete_category" do
  @category_to_delete = Category.find(params["id"])

  if @category_to_delete.delete_category
    erb :"general/success"
  else
    @error = true
    erb :"categories/delete_category"
  end
end
