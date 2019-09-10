# frozen_string_literal: true

class PassengerTrain < Train
  def couple!(car)
    super if car.instance_of? PassengerCar
  end
end
