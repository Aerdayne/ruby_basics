# frozen_string_literal: true

require_relative '../modules/manufacturer.rb'
require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'

# :nodoc:
class Train
  attr_reader :speed, :route, :cars, :id

  TRAIN_ID_REGEXP = /\A[a-zA-Z0-9]{3}[-]?[a-zA-Z0-9]{2}\z/.freeze

  include Manufacturer
  include Validation
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(id)
    @id = id
    @speed = 0
    @cars = []
    validate!
    @@trains[@id] = self
  end

  @@trains = {}

  def self.find(id)
    @@trains[id]
  end

  def increase_speed!(value)
    @speed += value if value.is_a? Numeric
  end

  def decrease_speed!(value)
    @speed -= value if value.is_a?(Numeric) && value <= @speed
  end

  def couple!(car)
    return unless car.is_a? RailCar

    @cars << car if car.coupled!(self)
  end

  def decouple!(car)
    return unless car.is_a? RailCar

    @cars.delete(car) if car.decoupled!
  end

  def assign_route!(route)
    return unless route.is_a? Route

    @route = route
    @current_station_id = 0
    current.host!(self)
  end

  def forwards!
    return if @route.nil? || current == route.destination

    current.depart!(self)
    @current_station_id += 1
    current.host!(self)
  end

  def backwards!
    return if @route.nil? || current == route.departure

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

  protected

  def validate!
    raise CustomException, 'ID should be a string' unless @id.instance_of? String
    raise CustomException, 'ID format should be XXX-XX or XXXXX' if @id !~ TRAIN_ID_REGEXP
  end
end
