class Identity
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :oauth_extra, type: Hash

  belongs_to :user

  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth)
  	find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
  def self.public_attrs
  	[:provider, :uid, :oauth_extra]
  end
end
