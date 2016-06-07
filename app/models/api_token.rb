class ApiToken
  include Mongoid::Document
  extend Enumerize
  field :token, type: String
  validates_uniqueness_of :token

  field :role, type: String

  enumerize :role, in: [:client, :admin], default: :client

  belongs_to :app
  validates_presence_of :app
  
  before_create :gen_token

  protected
  	def gen_token
      begin
        self.token = SecureRandom.hex
      end while self.class.where(token: token).exists?
  	end
end
