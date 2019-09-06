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
  attr_reader :course

  def initialize(departure, destination)
    @course = [departure, destination]
  end

  def departure
    @course[0]
  end

  def destination
    @course[-1]
  end

  def intermediate
    @course[1..-2]
  end

  def add_intermediate(station)
    @course.insert(-2, station)
  end

  def remove_intermediate(station)
    @course.delete(station) if @course[1..-2].delete(station)
  end

  def list_route
    @course.each { |station| print(station) }
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
    @car_quantity += 1 unless @speed.zero?
  end

  def decouple
    @car_quantity -= 1 unless @speed.zero?
  end

  def assign_route(route)
    @route = route
    @current_station_id = 0
    @route.course[@current_station_id].host(self)
  end

  # move to the next station
  def forwards
    return if @current_station_id == @route.course.length - 1

    @route.course[@current_station_id].depart(self)
    @current_station_id += 1
    @route.course[@current_station_id].host(self)
  end

  # move to the previous station
  def backwards
    return if @current_station_id.zero?

    @route.course[@current_station_id].depart(self)
    @current_station_id -= 1
    @route.course[@current_station_id].host(self)
  end

  def current
    @route.course[@current_station_id]
  end

  def previous
    @route.course[@current_station_id - 1] unless @current_station_id.zero?
  end

  def next
    @route.course[@current_station_id + 1] unless @current_station_id == @route.route.length
  end
end
