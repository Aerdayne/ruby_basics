class UnmatchingIdError < StandardError
  def message
    'Invalid ID format, should be XXX-XX or XXXXX'
  end
end