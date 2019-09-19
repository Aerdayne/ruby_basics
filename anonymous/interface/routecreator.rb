# frozen_string_literal: true

# :nodoc
class RouteCreator < Creator
  attr_reader :routes

  def initialize(creator)
    @creator = creator
    @calls = { 1 => ['Create a route', method(:new_route)],
               2 => ['Add station to a route', method(:add_station)],
               3 => ['Remove station from a route', method(:remove_station)],
               4 => ['List routes', method(:list_routes)] }
    @routes = []
  end

  def new_route
    puts 'Select the end-stations, first being the departure and second the destination:'
    departure = select_object(@creator.stationcreator.stations, 'station', &@creator.output_formats[:station_output])
    destination = select_object(@creator.stationcreator.stations, 'station', &@creator.output_formats[:station_output])
    @routes << Route.new(departure, destination) unless [departure, destination].any?(&:nil?)
  end

  def list_routes
    puts "\nRoutes list:"
    list_objects(@routes, 'route', &@creator.output_formats[:route_output])
  end

  def add_station
    route = select_object(@routes, 'route', &@creator.output_formats[:route_output])
    station = select_object(@creator.stationcreator.stations, 'station', &@creator.output_formats[:station_output])
    route.add_intermediate! station
  end

  def remove_station
    route = select_object(@routes, 'route', &@creator.output_formats[:route_output])
    station = select_object(route.stations, 'station', &@creator.output_formats[:station_output])
    route.remove_intermediate! station
  end
end
