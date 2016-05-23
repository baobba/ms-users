class App
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :domain, type: String
  field :token, type: String
  field :callback, type: String

  slug :name

	before_create :gen_token

  validates_uniqueness_of :name, :token

  protected
  	def gen_token
  		self.token = SecureRandom.urlsafe_base64 << SecureRandom.uuid
  	end
end
