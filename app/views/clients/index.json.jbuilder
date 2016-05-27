json.clients @clients do |client|
  json.(client, *Client.fields.keys)
  json.enterprises client.enterprises do |enterprise|
  	json.(enterprise, *Enterprise.fields.keys)
  	json.apps enterprise.apps do |app|
  		json.(app, *App.fields.keys)
  	end
  end
end
