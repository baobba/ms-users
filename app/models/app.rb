class App
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :domain, type: String
  field :token, type: String
  field :callback, type: String

  slug :name

  belongs_to :enterprise
  validates :enterprise, presence: true
  accepts_nested_attributes_for :enterprise

  before_create :gen_token
  before_validation :set_enterprise

  validates_uniqueness_of :name, :token

  public
    # will be included when listing apps or showing an specific app.
    def self.public_attrs
      [:name, :domain, :token, :callback]
    end


  protected
  	def gen_token
      self.token = SecureRandom.urlsafe_base64 << SecureRandom.uuid
  	end
    def set_enterprise
      self.enterprise = Enterprise.find(self.enterprise_id)
    end
end
