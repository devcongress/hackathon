class String
  # Returns true if the string is a valid base64 encoded string
  #
  def base64_encoded?
    match?(
      /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/
    )
  end
end
