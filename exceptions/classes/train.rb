# frozen_string_literal: true

require_relative '../modules/manufacturer.rb'
require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'
require_relative '../exceptions/argumenttypeerror.rb'
require_relative '../exceptions/unmatchingiderror.rb'
require_relative '../exceptions/routeerror.rb'
# :nodoc:
class Train
  attr_reader :speed, :route, :cars, :id

  TRAIN_ID_REGEXP = /\A[a-zA-Z0-9]{3}[-]?[a-zA-Z0-9]{2}\z/.freeze
  TRAIN_TYPES = %w[passenger cargo].freeze

  @@trains = {}

  include Manufacturer
  include Validation
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def self.train_types
    const_get('TRAIN_TYPES')
  end

  def self.find(id)
    return @@trains[id] if @@trains[id][1]

    @@trains[id][0]
  end

  def initialize(id)
    @id = id
    @speed = 0
    @cars = []
    (@@trains[@id] ||= []) << self
    validate!
  end

  def increase_speed!(value)
    validate! :increase_speed!, value
    @speed += value
  end

  def decrease_speed!(value)
    validate! :decrease_speed!, value
    @speed -= value
  end

  def couple!(car)
    validate! :couple!, car
    p self
    car.coupled! self
    @cars << car
  end

  def decouple!(car)
    validate! :decouple!, car
    car.decoupled!
    @cars.delete(car)
  end

  def assign_route!(route)
    validate! :assign_route!, route
    @route = route
    @current_station_id = 0
    current.host!(self)
  end

  def forwards!
    validate! :forwards!
    current.depart!(self)
    @current_station_id += 1
    current.host!(self)
  end

  def backwards!
    validate! :backwards!
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

  def validate!(*args)
    # Train#Initialize validation
    raise ArgumentTypeError unless @id.instance_of?(String)
    raise UnmatchingIdError if @id !~ TRAIN_ID_REGEXP

    # Method validation
    unless args.nil?
      case args[0]
      when :increase_speed!
        raise ArgumentTypeError unless args[1].is_a? Numeric
      when :decrease_speed!
        raise ArgumentTypeError unless args[1].is_a?(Numeric) && args[1] <= @speed && args[1].positive?
      when :couple!
        raise ArgumentTypeError unless args[1].is_a? RailCar
        raise DuplicateObjectError if @cars.include? args[1]
      when :decouple!
        raise ArgumentTypeError unless args[1].is_a? RailCar
      when :assign_route!
        raise ArgumentTypeError unless args[1].is_a? Route
      when :forwards!
        raise RouteError unless route && current != route.destination
      when :backwards!
        raise RouteError unless route && current != route.departure
      end
    end
  end
end
