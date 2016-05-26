json.app do
	json.(@app, *App.public_attrs)
  json.enterprise do
  	json.(@app.enterprise, *Enterprise.public_attrs)
  end
end