# frozen_string_literal: true

class Creator
  def initialize
    @passengertrains = []
    @cargotrains = []
    @stations = []
    @routes = []
  end

  def create_station!(name)
    @stations << Station.new(name.to_str)
  end

  def create_train!(type)
    case type
    when 'passenger'
      @passengertrains << PassengerTrain.new(@passengertrains.length)
    when 'cargo'
      @cargotrains << CargoTrain.new(@cargotrains.length)
    else
      puts 'Invalid train type'
    end
  end

  def create_route!(departure_id, destination_id)
    if @stations[departure_id.to_i].nil? || @stations[destination_id.to_i].nil?
      puts 'Invalid input or stations with entered IDs don\'t exist'
    else
      @routes << Route.new(@stations[departure_id.to_i], @stations[destination_id.to_i])
    end
  end

  def add_to_route!(route_id, station_id)
    if @routes[route_id.to_i].nil? || @stations[station_id.to_i].nil?
      puts 'Invalid input or objects with entered IDs don\'t exist'
    else
      @routes[route_id.to_i].add_intermediate! @stations[station_id.to_i]
    end
  end

  def remove_from_route!(route_id, route_station_id)
    if @routes[route_id.to_i].nil? || @routes[route_id.to_i].stations[route_station_id.to_i].nil?
      puts 'Invalid input or objects with entered IDs don\'t exist'
    else
      @routes[route_id.to_i].remove_intermediate! @routes[route_id.to_i].stations[route_station_id.to_i]
    end
  end

  def add_car!(type, id)
    case type
    when 'passenger'
      if @passengertrains.any? { |train| train.id == id.to_i }
        @passengertrains[id.to_i].couple! PassengerCar.new
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    when 'cargo'
      if @cargotrains.any? { |train| train.id == id.to_i }
        @cargotrains[id.to_i].couple! CargoTrain.new
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    else
      puts 'Input is invalid or such a train type doesn\'t exist'
    end
  end

  def remove_car!(type, id)
    case type
    when 'passenger'
      if @passengertrains.any? { |train| train.id == id.to_i }
        @passengertrains[id.to_i].decouple! @passengertrains[id.to_i].cars.last
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    when 'cargo'
      if @cargotrains.any? { |train| train.id == id.to_i }
        @cargotrains[id.to_i].decouple! @cargotrains[id.to_i].cars.last
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    else
      puts 'Input is invalid or such a train type doesn\'t exist'
    end
  end

  def set_train_route!(type, train_id, route_id)
    case type
    when 'passenger'
      if @passengertrains.any? { |train| train.id == train_id.to_i } && !@routes[route_id.to_i].nil?
        @passengertrains[train_id.to_i].assign_route! @routes[route_id.to_i]
      else
        puts 'Input is invalid or objects with entered IDs don\'t exist'
      end
    when 'cargo'
      if @cargotrains.any? { |train| train.id == train_id.to_i } && !@routes[route_id].nil?
        @cargotrains[train_id.to_i].assign_route! @routes[route_id.to_i]
      else
        puts 'Input is invalid or objects with entered IDs don\'t exist'
      end
    else
      puts 'Input is invalid or such a train type doesn\'t exist'
    end
  end

  def move!(type, train_id, direction)
    case type
    when 'passenger'
      if @passengertrains.any? { |train| train.id == train_id.to_i }
        if direction == 'forwards'
          @passengertrains[train_id.to_i].forwards!
        elsif direction == 'backwards'
          @passengertrains[train_id.to_i].backwards!
        else
          puts 'Invalid direction'
        end
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    when 'cargo'
      if @cargotrains.any? { |train| train.id == train_id.to_i }
        if direction == 'forwards'
          @cargotrains[train_id.to_i].forwards!
        elsif direction == 'backwards'
          @cargotrains[train_id.to_i].backwards!
        else
          puts 'Invalid direction'
        end
      else
        puts 'Input is invalid or a train with that ID doesn\'t exist'
      end
    end
  end

  def list_stations
    puts 'Created stations:'
    @stations.each_with_index do |station, id|
      puts 'ID ' + id.to_s + ' ' + station.name
      puts 'Trains currently at this station:'
      station.trains.each { |train| p train }
    end
  end

  def list_routes
    puts "\nCreated routes:"
    @routes.each_with_index do |route, id|
      puts 'Route ID ' + id.to_s
      route.list_route
    end
  end

  def list_trains(type)
    case type
    when 'passenger'
      puts 'Created passenger trains:'
      @passengertrains.each { |train| p train }
    when 'cargo'
      puts 'Created cargo trains:'
      @cargotrains.each { |train| p train }
    else
      puts "Trains of entered type don't exist"
    end
  end
end
