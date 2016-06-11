class App
  include Mongoid::Document
  include Mongoid::Slug
  
  field :name, type: String
  field :domain, type: String
  field :callback, type: String

  slug :name

  belongs_to :enterprise
  validates :enterprise, presence: true
  accepts_nested_attributes_for :enterprise

  has_one :api_token
  validates :api_token, presence: true

  has_many :users

  validates_uniqueness_of :name

  before_validation :set_enterprise, :set_api_token

  public
    # will be included when listing apps or showing an specific app.
    def self.public_attrs
      [:name, :domain, :api_token, :callback]
    end


  def set_enterprise
    if enterprise_id != nil && enterprise == nil
      self.enterprise = Enterprise.find(self.enterprise_id)
    end
  end
  def set_api_token
    self.api_token = ApiToken.create({app_id: self.id}) if self.api_token == nil
  end
  def get_app_id
    self.id
  end
end
