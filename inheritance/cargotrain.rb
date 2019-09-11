# frozen_string_literal: true

# :nodoc:
class CargoTrain < Train
  def couple!(car)
    super if car.instance_of? CargoCar
  end
end
