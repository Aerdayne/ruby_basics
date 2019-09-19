# frozen_string_literal: true

# :nodoc:
class PassengerCar < RailCar
  def initialize(seats = 50)
    @capacity = [seats, 0]
    validate!
  end

  def load
    @capacity[1] += 1 unless @capacity[1] == @capacity[0]
  end

  def coupled!(train)
    super if train.instance_of? PassengerTrain
  end

  protected

  def validate!
    raise CustomException, 'Number of seats should be an integer' unless @capacity[0].instance_of? Integer
    raise CustomException, 'Max seat capacity is 100' unless @capacity[0] <= 100 && @capacity[0] > 0
  end
end
