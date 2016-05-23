module ErrorSerializer
  def ErrorSerializer.serialize(errors)
    return if errors.nil?
    json = {}
    new_hash = errors.to_hash.map do |key, message|
      {
        attribute: key,
        message: message.join(". ") + "."
      }
    end.flatten

    json[:errors] = new_hash
    json
  end
end
