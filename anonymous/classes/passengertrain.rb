# frozen_string_literal: true

require_relative './train.rb'
# :nodoc:
class PassengerTrain < Train
  def couple!(car)
    super if car.instance_of? PassengerCar
  end
end
