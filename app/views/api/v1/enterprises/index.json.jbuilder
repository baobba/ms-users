json.enterprises @enterprises do |enterprise|
  json.(enterprise, *Enterprise.public_attrs)
end
