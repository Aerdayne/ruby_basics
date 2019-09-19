# frozen_string_literal: true

require_relative './railcar.rb'
require_relative '../exceptions/customexception.rb'
# :nodoc:
class CargoCar < RailCar
  def initialize(volume = 100)
    @capacity = [volume, 0]
    validate!
  end

  def load(volume)
    @capacity[1] += volume unless @capacity[1] + volume > @capacity[0] || volume < 1
  end

  def coupled!(train)
    super if train.instance_of? CargoTrain
  end

  protected

  def validate!
    raise CustomException, 'Volume size should be an integer' unless @capacity[0].instance_of? Integer
    raise CustomException, 'Max volume is 300' unless @capacity[0] <= 300 && @capacity[0] > 0
  end
end
