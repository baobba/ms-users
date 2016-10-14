json.user do
	json.id 									BSON::ObjectId.new
	json.app_id								BSON::ObjectId.new
	json.uuid 								SecureRandom.uuid
	json.uattr do
		json.attr1 							"value1"
		json.attr2 							123123
		json.attr3 							false
		json.attr4 do
			json.subattr1 				"sub value!"
			json.subattr2 				321
		end
		json.attr5 							["blah", "bleh"]
	end

	json.email								"email#{rand(10000)}@email.com"
	
	json.confirmation_token		SecureRandom.hex
	json.confirmed_at				"2016-10-14T01:18:33.353Z"
	json.confirmation_sent_at	"2016-10-14T01:18:33.353Z"
	json.unconfirmed_email		nil

	json.sign_in_count				0
	json.current_sign_in_at		nil
	json.last_sign_in_at			nil
	json.last_sign_in_ip			nil

	json.reset_password_token	nil

	json.identities [
		{
			provider: "facebook",
			uid: "81070",
			oauth_hash: {"provider":"facebook","uid":"81070","info":{"first_name":"FirstName","last_name":"LastName","email":"testemail82981@example.com","name":"FirstName LastName"},"credentials":{"token":"82981","expires_at":"2016-10-20T22:18:32.775-02:00"},"extra":{"raw_info":{"gender":"male","name":"FirstName"}}}
		},
		{
			provider: "twitter",
			uid: "82981",
			oauth_hash: {"provider":"facebook","uid":"82981","info":{"first_name":"FirstName","last_name":"LastName","email":"testemail82981@example.com","name":"FirstName LastName"},"credentials":{"token":"82981","expires_at":"2016-10-20T22:18:32.775-02:00"},"extra":{"raw_info":{"gender":"male","name":"FirstName"}}}
		}
	]
end