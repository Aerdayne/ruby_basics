# frozen_string_literal: true

class RailCar
  attr_reader :train

  def coupled!(train)
    @train = train
  end

  def decoupled!
    @train = nil
  end
end
