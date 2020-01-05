# frozen_string_literal: true

# :nodoc:
class PassengerCar < RailCar
  validate :capacity, :presence
  validate :capacity, :type, Integer
  validate :capacity, :range, 0, 100

  def initialize(capacity = 100)
    super(capacity)
    validate!
  end

  def load!
    super(1)
  end

  def coupled!(train)
    super if train.instance_of? PassengerTrain
  end
end
