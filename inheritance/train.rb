# frozen_string_literal: true

# :nodoc:
class Train
  attr_reader :speed, :route, :cars, :id

  def initialize(id)
    @id = id
    @speed = 0
    @cars = []
  end

  def increase_speed!(value)
    @speed += value
  end

  def decrease_speed!(value)
    @speed -= value unless @speed < value
  end

  def couple!(car)
    @cars << car if car.coupled! self
  end

  def decouple!(car)
    @cars.delete(car)
  end

  def current
    @route.stations[@current_station_id]
  end

  def previous
    @route.stations[@current_station_id - 1] unless current == @route.departure
  end

  def next
    @route.stations[@current_station_id + 1] unless current == @route.destination
  end

  def assign_route!(route)
    @route = route
    @current_station_id = 0
    current.host!(self)
  end

  def forwards!
    return if current == route.destination

    current.depart!(self)
    @current_station_id += 1
    current.host!(self)
  end

  def backwards!
    return if current == route.departure

    current.depart!(self)
    @current_station_id -= 1
    current.host!(self)
  end
end
