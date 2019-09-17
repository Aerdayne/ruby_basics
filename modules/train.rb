# frozen_string_literal: true

require_relative 'modules/manufacturer.rb'
require_relative 'modules/instancecounter.rb'

# :nodoc:
class Train
  attr_reader :speed, :route, :cars, :id

  include Manufacturer
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(id)
    @id = id
    @speed = 0
    @cars = []
    @@trains << self
  end

  @@trains = []

  # Since IDs aren't unique returns the first matching instance
  def self.find(id)
    @@trains.detect { |train| train.id == id }
  end

  def increase_speed!(value)
    @speed += value
  end

  def decrease_speed!(value)
    @speed -= value unless @speed < value
  end

  def couple!(car)
    return if car.nil?

    @cars << car if car.coupled!(self)
  end

  def decouple!(car)
    return if car.nil?

    @cars.delete(car) if car.decoupled!
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
