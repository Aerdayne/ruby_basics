# frozen_string_literal: true

# :nodoc:
class CargoCar < RailCar
  def coupled!(train)
    super if train.instance_of? CargoTrain
  end
end
