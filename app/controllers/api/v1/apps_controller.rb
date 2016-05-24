class Api::V1::AppsController < Api::V1::BaseController
	def app_params
		params.require(:app).permit(:name, :domain, :callback, :enterprise_id)
	end
end
