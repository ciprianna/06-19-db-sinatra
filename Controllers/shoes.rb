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

# ------------------------------------------------------------------------------
# Update a shoe's information
# ------------------------------------------------------------------------------
# Step 1: Lists all shoes to select which Shoe to update.
get "/update_product" do
  erb :"shoes/update_product"
end

# Step 2: Displays the form for the user to change with prefilled information
#   based on the current values of each field.
get "/update_product_form/:id" do
  @shoe_to_change = Shoe.find(params["id"])
  erb :"shoes/update_product_form"
end

# Step 3: Save updated shoe information
# - Creates new Shoe Object
# - Sets values of Object to params from the form
# - Saves the new values to the database if they're valid
get "/save_shoe_update" do
  @shoe_to_change = Shoe.find(params["id"])
  @shoe_to_change.name = params["name"]
  @shoe_to_change.cost = params["cost"]
  @shoe_to_change.color = params["color"]
  @shoe_to_change.category_id = params["category_id"]
  @shoe_to_change.location_id = params["location_id"]

  if @shoe_to_change.save_valid
    erb :"general/success"
  else
    @error = true
    erb :"shoes/update_product_form"
  end
end

# ------------------------------------------------------------------------------
# Deletes a shoe
# ------------------------------------------------------------------------------
# Step 1: Form listing all Shoes as options to select
get "/delete_shoe" do
  erb :"shoes/delete_shoe"
end

# Step 2: Deletes the Shoe from the database
get "/really_delete_shoe"do
  shoe_to_delete = Shoe.find(params["shoe_id"].to_i)

  if shoe_to_delete.delete
    erb :"general/success"
  else
    erb :"general/failure"
  end
end
