json.app do
  json.id    					@app.id
  json.name 					@app.name
  json.token					@app.token
  json.domain					@app.domain
  json.callback				@app.callback
end