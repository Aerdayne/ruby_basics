# frozen_string_literal: true

# :nodoc:
module Traverser
  def traverse(property, &block)
    property.each_with_index { |object, id| block.call(object, id) }
  end
end
