class Api::V1::EnterprisesController < Api::V1::BaseController
  def enterprise_params
    params.require(:enterprise).permit(:name, :home_url, :facebook_key, :linkedin_key, :google_key, :github_key, :twitter_key)
  end
end
