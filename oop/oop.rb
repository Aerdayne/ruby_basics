# frozen_string_literal: true

# :nodoc:
class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def host(train)
    @trains << train if train.current == self
  end

  def depart(train)
    @trains.delete(train) if train.current == self
  end

  def list_specififc(type)
    @trains.select { |train| train.type == type }
  end
end

# :nodoc:
class Route
  attr_reader :stations

  def initialize(departure, destination)
    @stations = [departure, destination]
  end

  def departure
    @stations[0]
  end

  def destination
    @stations[-1]
  end

  def add_intermediate(station)
    @stations.insert(-2, station)
  end

  def remove_intermediate(station)
    @stations.delete(station) unless [destination, departure].include? station
  end

  def list_route
    @stations.each { |station| print(station) }
  end
end

# :nodoc:
class Train
  attr_reader :speed, :car_quantity, :type, :route

  def initialize(id, type, car_quantity)
    @id = id
    @type = type
    @car_quantity = car_quantity
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value unless @speed < value
  end

  def couple
    @car_quantity += 1 if @speed.zero?
  end

  def decouple
    @car_quantity -= 1 if @speed.zero? && !@car_quantity.zero?
  end

  def assign_route(route)
    @route = route
    @current_station_id = 0
    current.host(self)
  end

  # move to the next station
  def forwards
    return if current == route.destination

    current.depart(self)
    @current_station_id += 1
    current.host(self)
  end

  # move to the previous station
  def backwards
    return if current == route.departure

    current.depart(self)
    @current_station_id -= 1
    current.host(self)
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
end
