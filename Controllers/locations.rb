# ------------------------------------------------------------------------------
# Displays options for location information
# ------------------------------------------------------------------------------
get "/location_information" do
  erb :"locations/location_information"
end

# ------------------------------------------------------------------------------
# Displays all location information
# ------------------------------------------------------------------------------
get "/all_locations" do
  erb :"locations/all_locations"
end

# ------------------------------------------------------------------------------
# Displays all shoes at a selected location
# ------------------------------------------------------------------------------
# Step 1: Display all locations to choose from in a Form
get "/shoes_at_a_location" do
  erb :"locations/shoes_at_a_location"
end

# Step 2: Displays all shoes at the selected location
get "/save_view_by_location" do
  @location_to_view = Location.find(params["location_id"])
  erb :"locations/save_view_by_location"
end

# ------------------------------------------------------------------------------
# Updates the name of a location
# ------------------------------------------------------------------------------
# Step 1: Display all locations to choose from in a Form
get "/change_location_name" do
  erb :"locations/change_location_name"
end

# Step 2: Takes information from the form, sets it, and saves it to the database.
get "/save_location_name" do
  location_to_change = Location.find(params["id"])
  location_to_change.name = params["new_name"]

  if location_to_change.save_valid
    erb :"general/success"
  else
    @error = true
    erb :"locations/change_location_name"
  end
end

# ------------------------------------------------------------------------------
# Add a new location
# ------------------------------------------------------------------------------
# Step 1: Displays an empty form
get "/add_location" do
  erb :"locations/add_location"
end

# Step 2: Sets the information from the form to a Location object and saves it
#   to the database
get "/save_new_location" do
  location_to_add = Location.new({"name" => params["name"]})

  if location_to_add.add_to_database
    erb :"general/success"
  else
    @error = true
    erb :"locations/add_location"
  end
end

# ------------------------------------------------------------------------------
# Delete a location
# ------------------------------------------------------------------------------
# Step 1: Displays existing locations in a form as options to select
get "/delete_location" do
  erb :"locations/delete_location"
end

# Step 2: Deletes the location if no shoes are saved there
get "/really_delete_location" do
  @location_to_delete = Location.find(params["id"])

  if @location_to_delete.delete_location
    erb :"general/success"
  else
    @error = true
    erb :"locations/delete_location"
  end
end
