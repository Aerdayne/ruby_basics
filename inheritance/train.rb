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
    return if car.nil?

    @cars << car
    car.coupled!(self)
  end

  def decouple!(car)
    return if car.nil?

    @cars.delete(car)
    car.decoupled!
  end

  def assign_route!(route)
    @route = route
    @current_station_id = 0
    current.host!(self)
  end

  def forwards!
    return if route.nil? || current == route.destination

    current.depart!(self)
    @current_station_id += 1
    current.host!(self)
  end

  def backwards!
    return if route.nil? || current == route.departure

    current.depart!(self)
    @current_station_id -= 1
    current.host!(self)
  end

  def current
    @route.stations[@current_station_id] unless @route.nil?
  end

  def previous
    @route.stations[@current_station_id - 1] unless @route.nil? || current == @route.departure
  end

  def next
    @route.stations[@current_station_id + 1] unless @route.nil? || current == @route.destination
  end
end
