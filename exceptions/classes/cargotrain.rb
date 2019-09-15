# frozen_string_literal: true

# :nodoc:
class CargoTrain < Train
  protected

  def validate!(*args)
    super
    if args[0] == :couple!
      raise ArgumentTypeError unless args[1].instance_of?(CargoCar)
    end
  end
end
