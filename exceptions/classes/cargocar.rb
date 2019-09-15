# frozen_string_literal: true

# :nodoc:
class CargoCar < RailCar
  protected
  
  def validate!(*args)
    raise ArgumentTypeError unless args[0].instance_of? CargoTrain
  end
end
