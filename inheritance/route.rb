# frozen_string_literal: true

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

  def add_intermediate!(station)
    @stations.insert(-2, station)
  end

  def remove_intermediate!(station)
    @stations.delete(station) unless [destination, departure].include? station
  end

  def list_route
    @stations.each_with_index { |station, id| puts 'Station ID ' + id.to_s + ' ' + station.name }
  end
end
