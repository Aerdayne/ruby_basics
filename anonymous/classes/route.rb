# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'

# :nodoc:
class Route
  attr_reader :stations

  include Traverser
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
    return unless station.instance_of?(Station) && !@stations.include?(station)

    @stations.insert(-2, station)
  end

  def remove_intermediate!(station)
    return unless station.instance_of?(Station) && ![@stations[0], @stations[-1]].include?(station)

    @stations.delete(station)
  end

  protected

  def validate!
    raise CustomException, 'Route should consist of stations!' unless @stations.all? { |station| station.instance_of? Station }
    raise CustomException, 'Route departure and destination can not be the same!' if @stations[0] == @stations[-1]
  end
end
