# frozen_string_literal: true

# :nodoc:
class PassengerCar < RailCar
  def coupled!(train)
    super if train.instance_of? PassengerTrain
  end
end
