json.apps @apps do |app|
  json.(app, *App.public_attrs)
  json.enterprise do
  	json.id 					app.enterprise.id
  	json.name 				app.enterprise.name
  	json.slug 				app.enterprise.slug
  end
end
