json.enterprises @enterprises do |enterprise|
  json.id         enterprise.id
  json.name       enterprise.name
  json.domain			enterprise.domain
  json.home_url   enterprise.home_url
  json._slug      enterprise._slugs
end
