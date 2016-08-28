module OmniauthMacros
	def valid_login_setup provider, rnumber = nil
		if rnumber.nil?
			rnumber = rand(100000)
		end
		if Rails.env.test? || Rails.env.development?
			OmniAuth.config.test_mode = true
			OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
				provider: provider,
				uid: rnumber.to_s,
				info: {
					first_name: 'FirstName',
					last_name: 'LastName',
					email: 'testemail' + rnumber.to_s + '@example.com'
				},
				credentials: {
					token: rnumber.to_s,
					expires_at: Time.now + 1.week
				},
				extra: {
					raw_info: {
						gender: 'male',
						name: 'FirstName'
					}
				}
			})
		else
			throw "Macro not available in '" + ENV['RAILS_ENV'] + "' environment. Should be 'test' or 'development'" 
		end
	end
end