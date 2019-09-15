# frozen_string_literal: true

# :nodoc:
class RailCar
  attr_reader :train

  include Manufacturer
  include Validation

  def coupled!(train)
    validate! train
    @train = train
  end

  def decoupled!
    @train = nil
  end

  protected

  def validate!(*args)
    raise ArgumentTypeError unless args[0].is_a? Train
  end
end
