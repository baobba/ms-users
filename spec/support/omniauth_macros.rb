module OmniauthMacros
	def valid_login_setup provider
		if Rails.env.test?
			OmniAuth.config.test_mode = true
			OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
				provider: provider,
				uid: rand(100000).to_s,
				info: {
					first_name: 'FirstName',
					last_name: 'LastName',
					email: 'testemail' + rand(10000).to_s + '@example.com'
				},
				credentials: {
					token: rand(100000).to_s,
					expires_at: Time.now + 1.week
				},
				extra: {
					raw_info: {
						gender: 'male',
						name: 'FirstName'
					}
				}
			})
		end
	end
end