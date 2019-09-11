# frozen_string_literal: true

# :nodoc:
class RailCar
  attr_reader :train

  def coupled!(train)
    return if train.nil?

    @train = train
  end

  def decoupled!
    @train = nil
    true
  end
end
