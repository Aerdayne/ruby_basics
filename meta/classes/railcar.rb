# frozen_string_literal: true

# :nodoc:
class RailCar
  prepend Accessors
  prepend InstanceCounter

  include Validation
  include Traverser
  include Manufacturer

  attr_accessor_with_history :train

  validate :capacity, :presence
  validate :capacity, :type, Integer

  def initialize(capacity)
    @capacity = capacity
    @loaded = 0
    validate!
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
