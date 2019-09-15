# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'
require_relative '../exceptions/argumenttypeerror.rb'

# :nodoc:
class Route
  attr_reader :stations

  include Validation
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(departure, destination)
    @stations = [departure, destination]
    validate!
  end

  def departure
    @stations[0]
  end

  def destination
    @stations[-1]
  end

  def add_intermediate!(station)
    validate! :add_intermediate!, station
    @stations.insert(-2, station)
  end

  def remove_intermediate!(station)
    validate! :remove_intermediate!, station
    @stations.delete(station)
  end

  def list_route
    @stations.each_with_index { |station, id| puts '  Station ID: ' + id.to_s + ' Station name: ' + station.name }
  end

  protected

  def validate!(*args)
    # Route#Initialize validation
    raise ArgumentTypeError unless @stations.all? { |station| station.instance_of? Station}

    unless args.nil?
      case args[0]
      when :add_intermediate!
        raise ArgumentTypeError unless args[1].instance_of? Station
        raise DuplicateObjectError if @stations.include? args[1]
      when :remove_intermediate!
        raise ArgumentTypeError unless args[1].instance_of?(Station) && @stations.include?(args[1])
        raise ObjectIntegrityError if [destination, departure].include? args[1]
      end
    end
  end
end
