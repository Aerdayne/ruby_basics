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

  protected

  def new_route
    puts 'Select the end-stations, first being the departure and second the destination:'
    departure = select_object(@creator.stationcreator.stations, 'station', &@creator.output[:station])
    destination = select_object(@creator.stationcreator.stations, 'station', &@creator.output[:station])
    @routes << Route.new(departure, destination)
  end

  def list_routes
    puts "\nRoutes list:"
    list_objects(@routes, 'route', &@creator.output[:route])
  end

  def add_station
    route = select_object(@routes, 'route', &@creator.output[:route])
    station = select_object(@creator.stationcreator.stations, 'station', &@creator.output[:station])
    route.add_intermediate! station
  end

  def remove_station
    route = select_object(@routes, 'route', &@creator.output[:route])
    station = select_object(route.stations, 'station', &@creator.output[:station])
    raise CustomException, 'Can not remove an end-station!' unless route.remove_intermediate! station
  end
end
