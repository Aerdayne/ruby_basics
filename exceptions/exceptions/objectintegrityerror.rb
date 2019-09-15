class ObjectIntegrityError < ArgumentError
  def message
    'Object is already used by something else'
  end
end