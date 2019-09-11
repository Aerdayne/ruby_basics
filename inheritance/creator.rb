# frozen_string_literal: true

# Railroad instance class
class Creator
  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def create_station!(name)
    if name
      @stations << Station.new(name.to_str)
    else
      puts 'Name is invalid'
    end
  end

  def create_train!(type)
    case type
    when 'passenger'
      @trains << PassengerTrain.new(@trains.length)
    when 'cargo'
      @trains << CargoTrain.new(@trains.length)
    else
      puts 'Invalid train type'
    end
  end

  # Takes both station's indices from @stations
  def create_route!(departure_id, destination_id)
    if get_station(departure_id) != get_station(destination_id)
      @routes << Route.new(get_station(departure_id), get_station(destination_id))
    else
      puts 'Invalid IDs or specified stations are the same one'
    end
  end

  # Takes route's index from @routes array and station's index from @stations
  def add_to_route!(route_id, station_id)
    if get_route(route_id).add_intermediate! get_station(station_id)
      puts 'Added a station'
    else
      puts 'Invalid IDs or the specified station is already a part of route'
    end
  end

  # Takes route's index from @routes array and station's index from route.stations array
  def remove_from_route!(route_id, route_station_id)
    if get_route(route_id).remove_intermediate! get_station_from_route(route_id, route_station_id)
      puts 'Removed a station'
    else
      puts 'Invalid IDs or the specified station is an end-station'
    end
  end

  # Takes train's index from @trains array
  def add_car!(id)
    if get_train(id).instance_of? CargoTrain
      get_train(id).couple!(CargoCar.new)
    elsif get_train(id).instance_of? PassengerTrain
      get_train(id).couple!(PassengerCar.new)
    else
      puts 'Invalid ID'
    end
  end

  # Takes train's index from @trains array
  def remove_car!(id)
    if get_train(id)
      get_train(id).decouple!(get_train(id).cars.last)
    else
      puts 'Invalid ID'
    end
  end

  # Takes train's index from @trains array and route's index from @routes array
  def set_train_route!(train_id, route_id)
    if get_train(train_id) && get_route(route_id)
      get_train(train_id).assign_route! get_route(route_id)
    else
      puts 'Invalid train ID or route ID'
    end
  end

  # Takes train's index from @trains array and direction parameter
  def move!(train_id, direction)
    if get_train(train_id)
      if direction == 'forwards'
        get_train(train_id).forwards!
      elsif direction == 'backwards'
        get_train(train_id).backwards!
      else
        puts 'Invalid direction'
      end
    else
      puts 'Invalid ID'
    end
  end

  def list_stations
    puts 'Created stations:'
    @stations.each_with_index do |station, id|
      puts 'Station ID: ' + id.to_s + ' Station name: ' + station.name
      puts '  Trains currently at this station:'
      if station.trains.any?
        station.trains.each { |train| puts '    Train ID: ' + train.id.to_s + ' Train type: ' + train.class.name.split('::').last }
      else
        puts '    None'
      end
    end
  end

  def list_routes
    puts 'Created routes:'
    @routes.each_with_index do |route, id|
      puts 'Route ID: ' + id.to_s
      route.list_route
    end
  end

  def list_trains(type)
    case type
    when 'passenger'
      puts "Created passenger trains:\n"
      @trains.select { |train| train.instance_of? PassengerTrain }.each { |train| p train }
    when 'cargo'
      puts "Created cargo trains:\n"
      @trains.select { |train| train.instance_of? CargoTrain }.each { |train| p train }
    when 'all'
      puts "Created trains of any type:\n"
      @trains.each_with_index { |train, id| puts 'Train ID: ' + id.to_s + ' ' + train.class.name.split('::').last }
    else
      puts 'Invalid type'
    end
  end

  def get_station(id)
    @stations[id.to_i]
  end

  def get_route(id)
    @routes[id.to_i]
  end

  def get_train(id)
    @trains[id.to_i]
  end

  def get_station_from_route(route_id, station_id)
    @routes[route_id.to_i].stations[station_id.to_i]
  end
end
