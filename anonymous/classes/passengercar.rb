# frozen_string_literal: true

# :nodoc:
class PassengerCar < RailCar
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

  protected

  def validate!
    raise CustomException, 'Number of seats should be an integer' unless @capacity.instance_of? Integer
    raise CustomException, 'Max seat capacity is 100' unless @capacity <= 100 && @capacity > 0
  end
end
