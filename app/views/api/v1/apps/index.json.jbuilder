json.apps @apps do |app|
  json.(app, *app.attributes.keys)
  json.enterprise do
  	json.id						app.enterprise.id
  	json.name 				app.enterprise.name
  	json.home_url			app.enterprise.home_url
  	json._slugs				app.enterprise._slugs
  end
end
