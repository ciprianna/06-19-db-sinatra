# ------------------------------------------------------------------------------
# Displays home menu for all options in the management system
# ------------------------------------------------------------------------------
get "/home" do
  erb :"general/index"
end

# ------------------------------------------------------------------------------
# Displays options for the Quantity Information menu
# ------------------------------------------------------------------------------
get "/quantity_information" do
  erb :"general/quantity_information"
end

# ------------------------------------------------------------------------------
# Displays all Shoes and quantities
# ------------------------------------------------------------------------------
get "/view_quantities" do
  erb :"general/view_quantities"
end

# ------------------------------------------------------------------------------
# Displays all Shoes that have low quantity values
# ------------------------------------------------------------------------------
get "/low_quantities" do
  erb :"general/low_quantities"
end

# ------------------------------------------------------------------------------
# Updates quantity of a shoe
# ------------------------------------------------------------------------------
# Step 1: Displays form with Shoes as options to select
get "/update_quantities" do
  erb :"general/update_quantities"
end

# Step 2: Creates Shoe Object and updates the quantity from params
get "/save_quantity_update" do
  shoe_to_update = Shoe.find(params["shoe_id"].to_i)

  if shoe_to_update.update_quantity(params["new_quantity"].to_i)
    erb :"general/success"
  else
    erb :"general/failure"
  end
end

# ------------------------------------------------------------------------------
# Displays shoes by cost
# ------------------------------------------------------------------------------
# Step 1: A form with options for cost categories to select
get "/view_by_cost" do
  erb :"general/view_by_cost"
end

# Step 2: Displays shoes that match the cost category
get "/cost_category" do
  erb :"general/cost_category"
end
