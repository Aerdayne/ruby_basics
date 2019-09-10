# frozen_string_literal: true

class CargoTrain < Train
  def couple!(car)
    super if car.instance_of? CargoCar
  end
end
