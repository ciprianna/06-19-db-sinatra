# ------------------------------------------------------------------------------
# Displays options for location information
# ------------------------------------------------------------------------------
get "/category_information" do
  erb :"categories/category_information"
end

# ------------------------------------------------------------------------------
# Displays all category information
# ------------------------------------------------------------------------------
get "/all_categories" do
  erb :"categories/all_categories"
end

# ------------------------------------------------------------------------------
# Displays all shoes at a selected category
# ------------------------------------------------------------------------------
# Step 1: Display all category to choose from in a Form
get "/shoes_in_a_category" do
  erb :"categories/shoes_in_a_category"
end
# Step 2: Displays all shoes in the selected Category
get "/save_view_by_category" do
  @category_to_view = Category.find(params["category_id"])
  erb :"categories/save_view_by_category"
end

# ------------------------------------------------------------------------------
# Updates the name of a category
# ------------------------------------------------------------------------------
# Step 1: Display all categories to choose from in a Form
get "/change_category_name" do
  erb :"categories/change_category_name"
end

# Step 2: Takes information from the form, sets it, and saves it to the database.
get "/save_category_name" do
  category_to_change = Category.find(params["id"])
  category_to_change.name = params["new_name"]

  if category_to_change.save_valid
    erb :"general/success"
  else
    @error = true
    erb :"categories/change_category_name"
  end
end

# ------------------------------------------------------------------------------
# Add a new category
# ------------------------------------------------------------------------------
# Step 1: Displays an empty form
get "/add_category" do
  erb :"categories/add_category"
end

# Step 2: Sets the information from the form to a Category object and saves it
#   to the database
get "/save_new_category" do
  category_to_add = Category.new({"name" => params["name"]})

  if category_to_add.add_to_database
    erb :"general/success"
  else
    @error = true
    erb :"categories/add_category"
  end
end

# ------------------------------------------------------------------------------
# Deletes a category
# ------------------------------------------------------------------------------
# Step 1: Displays existing categories in a form as options to select
get "/delete_category" do
  erb :"categories/delete_category"
end

# Step 2: Deletes the location if no shoes are saved there
get "/really_delete_category" do
  @category_to_delete = Category.find(params["id"])

  if @category_to_delete.delete_category
    erb :"general/success"
  else
    @error = true
    erb :"categories/delete_category"
  end
end
