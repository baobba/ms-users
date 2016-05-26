json.users @users do |user|
  json.(user, *User.public_attrs)
  if user.identities != nil
	  json.identities user.identities do |identity|
	  	json.(identity, *Identity.public_attrs)
	  end
	end
end
