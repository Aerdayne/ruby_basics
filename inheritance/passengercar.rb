# frozen_string_literal: true

class PassengerCar < RailCar
  def coupled!(train)
    super if train.instance_of? PassengerTrain
  end
end
