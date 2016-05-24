json.enterprise do
  json.id         @enterprise.id
  json.name       @enterprise.name
  json.home_url   @enterprise.home_url
  json._slug      @enterprise.slug
end
