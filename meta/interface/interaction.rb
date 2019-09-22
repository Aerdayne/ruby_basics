# frozen_string_literal: true

# :nodoc:
class Interaction
  def initialize
    @master = Creator.new
  end

  def start
    @master.start
  end
end
