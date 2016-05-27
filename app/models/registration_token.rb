class RegistrationToken
  include Mongoid::Document
  extend Enumerize

  field :token, type: String
  field :expires_at, type: String
  field :status, type: String

  belongs_to :client

  enumerize :status, in: [:expired, :used, :unused], default: :unused

  validates_uniqueness_of :token

  before_create :gen_token, :set_expires_at

  def gen_token
    begin
      self.token = SecureRandom.hex
    end while self.class.where(token: token).exists?
	end
	def set_expires_at
		if self.expires_at == nil
			self.expires_at = Time.now + 1.week
		end
	end
end
