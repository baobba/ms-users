json.users @users do |user|
  json.(user, *User.public_attrs)
  if user.identities != nil
	  json.identities user.identities do |identity|
	  	json.provider identity.provider
	  	json.uid identity.uid
	  	json.oauth_hash JSON.parse(identity.oauth_hash)
	  end
	end
end
