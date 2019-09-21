# frozen_string_literal: true

# :nodoc:
module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
