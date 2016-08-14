class Enterprise
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :domain, type: String
  field :home_url, type: String
  field :facebook_id, type: String
  field :facebook_key, type: String
  field :google_oauth2_id, type: String
  field :google_oauth2_key, type: String
  field :linkedin_id, type: String
  field :linkedin_key, type: String
  field :github_id, type: String
  field :github_key, type: String
  field :twitter_id, type: String
  field :twitter_key, type: String

  slug :name

  has_many :apps

  belongs_to :client
  validates_presence_of :client_id, :name, :domain

  validates_uniqueness_of :name

  # will be included when listing enterprises or showing an specific enterprise.
  def self.public_attrs
    [:id, :name, :domain, :home_url, :slug, :facebook_id, :facebook_key, :google_oauth2_id, :google_oauth2_key, :linkedin_id, :linkedin_key, :github_id, :github_key, :twitter_id, :twitter_key]
  end
  def get_client_id
    client_id
  end
end
