# frozen_string_literal: true

require_relative './train.rb'
# :nodoc:
class CargoTrain < Train
  def couple!(car)
    super if car.instance_of? CargoCar
  end
end
