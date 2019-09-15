# frozen_string_literal: true

# :nodoc:
class PassengerCar < RailCar
  protected

  def validate!(*args)
    raise ArgumentTypeError unless args[0].instance_of? PassengerTrain
  end
end
