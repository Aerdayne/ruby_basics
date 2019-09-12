# Text interface class
class Interaction
  def initialize(creator)
    @master = creator
  end

  def start
    loop do
      puts "\n" + 'To create objects, type '.ljust(40) + "'create'"
      puts 'To interact with objects, type '.ljust(40) + "'interact'"
      puts 'To list objects, type '.ljust(40) + "'list'"
      puts 'To finish, type '.ljust(40) + "'exit'\n\n"
      input = gets.chomp.split
      case input[0]
      when 'create'
        create
      when 'interact'
        interact
      when 'list'
        list
      when 'exit'
        break
      else
        puts 'Invalid command!'
      end
    end
  end

  protected

  def create
    puts "\n" + 'To create a train, type '.ljust(40) + "'train <type>', types are: cargo, passenger"
    puts 'To create a station, type '.ljust(40) + "'station <name>'"
    puts 'To create a route, type '.ljust(40) + "'route'"
    puts 'To go back, type '.ljust(40) + "'back'\n\n"
    loop do
      input = gets.chomp.split
      case input[0]
      when 'train'
        puts 'Train created!' if @master.create_train!(input[1])
      when 'station'
        puts 'Station created!' if @master.create_station!(input[1])
      when 'route'
        puts 'Route created!' if create_route!
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  end

  def interact
    loop do
      puts "\n" + 'To interact with trains, type '.ljust(40) + "'train'"
      puts 'To interact with routes, type '.ljust(40) + "'route'"
      puts 'To go back, type '.ljust(40) + "'back'\n\n"
      input = gets.chomp
      case input
      when 'train'
        train_choice
      when 'route'
        route_choice
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  end

  def train_choice
    @master.list_trains('all')
    puts 'Enter the ID of a train to interact with: '
    input = gets.chomp
    if @master.get_train(input)
      train_interaction(input.to_i)
    else
      puts 'A train with specified ID does not exist.'
    end
  end

  def route_choice
    @master.list_routes
    puts 'Enter the ID of a route to interact with: '
    input = gets.chomp
    if @master.get_route(input)
      route_interaction(input.to_i)
    else
      puts 'A route with specified ID does not exist.'
    end
  end

  def train_interaction(id)
    puts "\n" + 'To add railcars to a train, type '.ljust(40) + "'add'"
    puts 'To remove railcars from a train, type '.ljust(40) + "'remove'"
    puts 'To move a train, type '.ljust(40) + "'move <direction>', directions are 'forwards' and 'backwards'"
    puts 'To assign a route to a train, type '.ljust(40) + "'assign <route_id>'"
    @master.list_routes
    puts 'To go back, type '.ljust(40) + "'back'\n\n"
    loop do
      input = gets.chomp.split
      case input[0]
      when 'add'
        puts 'Added a car.' if @master.add_car!(id)
      when 'remove'
        if @master.remove_car!(id)
          puts 'Removed a car.'
        else
          puts 'No cars left.'
        end
      when 'move'
        if @master.move!(id, input[1])
          puts 'Train moved ' + input[1] + '.'
        else
          puts 'Route is not set or end-station is reached'
        end
      when 'assign'
        puts 'Route assigned.' if @master.set_train_route!(id, input[1])
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  end

  def route_interaction(id)
    puts "\n" + 'To add stations to a route, type'.ljust(40) + "'add <station_id>'"
    @master.list_stations
    puts 'To remove stations from a route, type'.ljust(40) + "'remove <station_id>'"
    @master.list_routes
    puts 'To go back, type '.ljust(40) + "'back'\n\n"
    loop do
      input = gets.chomp.split
      case input[0]
      when 'add'
        @master.add_to_route!(id, input[1])
      when 'remove'
        @master.remove_from_route!(id, input[1])
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  end

  def create_route!
    @master.list_stations
    puts 'Enter IDs of both end-stations.'
    input = gets.chomp.split
    @master.create_route!(input[0], input[1])
  end

  def list
    puts "\n" + 'To list trains, type '.ljust(40) + "'trains <type>', types are 'cargo', 'passenger', 'all'"
    puts 'To list stations, type '.ljust(40) + "'stations'"
    puts 'To list routes, type '.ljust(40) + "'routes'"
    puts 'To go back, type '.ljust(40) + "'back'\n\n"
    loop do
      input = gets.chomp.split
      case input[0]
      when 'trains'
        @master.list_trains(input[1])
      when 'stations'
        @master.list_stations
      when 'routes'
        @master.list_routes
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  end
end