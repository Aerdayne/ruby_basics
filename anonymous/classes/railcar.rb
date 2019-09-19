# frozen_string_literal: true

# :nodoc:
class RailCar
  attr_reader :train, :capacity

  include Traverser
  include Manufacturer

  def coupled!(train)
    return unless train.is_a? Train

    @train = train
  end

  def decoupled!
    @train = nil
    true
  end
end
