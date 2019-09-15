class DuplicateObjectError < StandardError
  def message
    'Specified object is already a part of the collection'
  end
end