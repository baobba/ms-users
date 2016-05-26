class Enterprise
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :domain, type: String
  field :home_url, type: String
  field :facebook_id, type: String
  field :facebook_key, type: String
  field :google_id, type: String
  field :google_key, type: String
  field :linkedin_id, type: String
  field :linkedin_key, type: String
  field :github_id, type: String
  field :github_key, type: String
  field :twitter_id, type: String
  field :twitter_key, type: String

  slug :name

  has_many :apps

  belongs_to :client
  validates :client_id, presence: true

  validates_uniqueness_of :name

  # will be included when listing enterprises or showing an specific enterprise.
  def self.public_attrs
    [:id, :name, :domain, :home_url, :_slugs]
  end
  def get_client_id
    client_id
  end
end
