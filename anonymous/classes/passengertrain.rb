# frozen_string_literal: true

require_relative './train.rb'
# :nodoc:
class PassengerTrain < Train
  def initialize(id)
    @type = 'passenger'
    super
  end

  def couple!(car)
    super if car.instance_of? PassengerCar
  end
end
