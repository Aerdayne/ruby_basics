# frozen_string_literal: true

# :nodoc:
class RailCar
  attr_reader :train

  include Traverser
  include Manufacturer

  def initialize(capacity)
    @capacity = capacity
    @loaded = 0
  end

  def volume_total
    @capacity
  end

  def volume_available
    @capacity - @loaded
  end

  def load!(volume)
    @loaded += volume unless @loaded + volume > @capacity || volume < 1
  end

  def coupled!(train)
    return unless train.is_a? Train

    @train = train
  end

  def decoupled!
    @train = nil
    true
  end
end
