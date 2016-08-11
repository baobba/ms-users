require 'jwt'

module AuthToken
	def AuthToken.issue_token(payload)
		payload['exp'] = 24.hours.from_now.to_i
		JWT.encode(payload, Rails.application.secrets.secret_key_base)
	end
	def AuthToken.valid?(token)
		begin
			JWT.decode(token, Rails.application.secrets.secret_key_base)
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