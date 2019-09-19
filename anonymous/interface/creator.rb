# frozen_string_literal: true

# :nodoc:
class Creator
  attr_reader :calls, :output_formats, :traincreator, :carcreator, :stationcreator, :routecreator

  def initialize
    @traincreator = TrainCreator.new(self)
    @carcreator = CarCreator.new(self)
    @stationcreator = StationCreator.new(self)
    @routecreator = RouteCreator.new(self)
    @calls = { 1 => ['Train menu', @traincreator.method(:start)],
               2 => ['Car menu', @carcreator.method(:start)],
               3 => ['Station menu', @stationcreator.method(:start)],
               4 => ['Route menu', @routecreator.method(:start)] }
    @output_formats =
      { station_output:
        lambda { |station, id|
          puts "##{id} Station name: #{station.name}"
          station.traverse(station.trains, &@output_formats[:train_output])
        },
        train_output:
        lambda { |train, id|
          puts "##{id} Train ID: #{train.id} | Train type: #{train.class.name} | Cars attached: #{train.cars.length}"
          train.traverse(train.cars, &@output_formats[:car_output])
        },
        car_output:
        lambda { |car, id|
          puts "##{id} Car type: #{car.class.name} | Capacity (total\\occupied): #{car.capacity.join('\\')}"
        },
        route_output:
        lambda { |route, id|
          puts "Route ##{id} | Amount of stations: #{route.stations.length}"
          route.traverse(route.stations, &@output_formats[:station_output])
        },
        parameter_output:
        lambda { |parameter, id|
          puts "#{id} - #{parameter}"
        } }
  end

  def start
    action_choice(@calls)
  rescue CustomException => e
    puts e.message
    retry
  end

  def action_choice(actions)
    loop do
      puts "\nChoose an action:"
      actions.each do |key, value|
        puts "#{key.to_i} - #{value[0]}"
      end
      puts "To go back to the previous menu or exit, type 'back'"
      input = gets.chomp
      break if input == 'back'

      raise CustomException, 'Invalid action!' unless input.to_i.between?(1, actions.length)

      @calls[input.to_i][1].call
    end
  end

  def select_object(property, type = 'object', &block)
    raise CustomException, "No #{type}s created!" if property.empty?

    puts "Choose the #{type}:"
    property.each_with_index { |object, id| block.call(object, id + 1) }
    input = gets.chomp
    raise CustomException, 'Invalid ID!' unless input.to_i.between?(1, property.length)

    property[input.to_i - 1]
  end

  def list_objects(property, type = 'object', &block)
    if property.empty?
      puts "No #{type}s created!"
      return
    end
    property.each_with_index { |object, id| block.call(object, id + 1) }
  end
end
