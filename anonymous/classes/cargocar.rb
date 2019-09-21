# frozen_string_literal: true

require_relative './railcar.rb'
require_relative '../exceptions/customexception.rb'
# :nodoc:
class CargoCar < RailCar
  def initialize(capacity = 100)
    super(capacity)
    validate!
  end

  def coupled!(train)
    super if train.instance_of? CargoTrain
  end

  protected

  def validate!
    raise CustomException, 'Volume size should be an integer' unless @capacity.instance_of? Integer
    raise CustomException, 'Max volume is 300' unless @capacity <= 300 && @capacity > 0
  end
end
