Mongoid.load!(Rails.root.to_s + "/config/mongoid.yml")

module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json
    end

    def as_json(*args)
      to_s.as_json
    end
  end
end