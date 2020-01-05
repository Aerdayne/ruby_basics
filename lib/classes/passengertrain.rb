# frozen_string_literal: true

# :nodoc:
class PassengerTrain < Train
  validate :id, :presence
  validate :id, :type, String
  validate :id, :format, TRAIN_ID_REGEXP

  def couple!(car)
    super if car.instance_of? PassengerCar
  end
end
