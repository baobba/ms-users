require 'jwt'

module AuthToken
	def AuthToken.issue_token(payload)
		JWT.encode(payload, Rails.application.secrets.secret_key_base)
	end
	def AuthToken.valid?(token)
		begin
			jwt_obj = JWT.decode(token, Rails.application.secrets.secret_key_base)
			if Time.at(jwt_obj[0]["exp"]) >= Time.now
				return jwt_obj
			else
				return false
			end
		rescue
			false
		end
	end
	def AuthToken.get_data(token)
		dec = self.valid?(token)
		if dec
			return dec[0]
		else
			return nil
		end
	end
end