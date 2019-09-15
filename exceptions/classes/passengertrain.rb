# frozen_string_literal: true

# :nodoc:
class PassengerTrain < Train
  protected

  def validate!(*args)
    super
    if args[0] == :couple!
      raise ArgumentTypeError unless args[1].instance_of?(PassengerCar)
    end
  end
end
