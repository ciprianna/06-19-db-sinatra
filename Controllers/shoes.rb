# ------------------------------------------------------------------------------
# Displays all shoes
# ------------------------------------------------------------------------------
get "/current_stock" do
  erb :"shoes/current_stock"
end

# ------------------------------------------------------------------------------
# Add a new shoe
# ------------------------------------------------------------------------------
# Step 1: Display the empty form for a new item.
get "/add_shoe" do
  erb :"shoes/add_shoe"
end

# Step 2: Save the new Shoe information entered from the form.
# - Creates new Shoe Object
# - Runs the add_to_database to run validity check on information entered.
# - Routes to success or an error message.
get "/save_new_shoe" do
  shoe_to_add = Shoe.new({"name" => params["name"], "cost" => params["cost"].to_i, "color" => params["color"], "category_id" => params["category_id"].to_i, "location_id" => params["location_id"].to_i, "location_stock" => params["location_stock"].to_i})

  if shoe_to_add.add_to_database
    erb :"general/success"
  else
    @error = true
    erb :"shoes/add_shoe"
  end
end

get "/update_product" do
  erb :"shoes/update_product"
end

get "/save_shoe_update" do
  shoe_to_change = Shoe.find(params["shoe_id"])
  shoe_to_change.name = params["name"]
  shoe_to_change.cost = params["cost"]
  shoe_to_change.color = params["color"]
  shoe_to_change.category_id = params["category_id"]
  shoe_to_change.location_id = params["location_id"]

  if shoe_to_change.save_valid
    erb :"general/success"
  else
    erb :"general/failure"
  end
end
