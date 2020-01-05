# frozen_string_literal: true

# :nodoc:
class CargoCar < RailCar
  validate :capacity, :presence
  validate :capacity, :type, Integer
  validate :capacity, :range, 0, 300

  def initialize(capacity = 100)
    super(capacity)
    validate!
  end

  def coupled!(train)
    super if train.instance_of? CargoTrain
  end
end
