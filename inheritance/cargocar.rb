# frozen_string_literal: true

class CargoCar < RailCar
  def coupled!(train)
    super if train.instance_of? CargoTrain
  end
end
