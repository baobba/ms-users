class Enterprise
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :home_url, type: String
  field :facebook_key, type: String
  field :google_key, type: String
  field :linkedin_key, type: String
  field :github_key, type: String
  field :twitter_key, type: String

  slug :name

  has_many :apps

  validates_uniqueness_of :name
end
