# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'
require_relative '../exceptions/customexception.rb'

# :nodoc:
class Route
  prepend Accessors
  prepend InstanceCounter

  include Validation
  include Traverser

  attr_accessor_with_history :stations

  validate :stations, :presence
  validate :stations, :route_validity

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
    return unless station.instance_of?(Station) && !@stations.include?(station)

    @stations.insert(-2, station)
  end

  def remove_intermediate!(station)
    return unless station.instance_of?(Station) && ![@stations[0], @stations[-1]].include?(station)

    @stations.delete(station)
  end
end
