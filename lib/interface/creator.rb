# frozen_string_literal: true

# :nodoc:
class Creator
  attr_reader :calls, :output, :traincreator, :carcreator, :stationcreator, :routecreator

  def initialize
    @traincreator = TrainCreator.new(self)
    @carcreator = CarCreator.new(self)
    @stationcreator = StationCreator.new(self)
    @routecreator = RouteCreator.new(self)
    @calls = { 1 => ['Train menu', @traincreator.method(:start)],
               2 => ['Car menu', @carcreator.method(:start)],
               3 => ['Station menu', @stationcreator.method(:start)],
               4 => ['Route menu', @routecreator.method(:start)] }
    @output =
      { station:
        lambda { |station, id|
          puts "##{id} Station name: #{station.name}"
          station.traverse(station.trains, &@output[:train])
        },
        train:
        lambda { |train, id|
          puts "##{id} Train ID: #{train.id} | Train type: #{train.class.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')} | Cars attached: #{train.cars.length}"
          train.traverse(train.cars, &@output[:car])
        },
        car:
        lambda { |car, id|
          puts "##{id} Car type: #{car.class.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')} | Capacity (total\\available): #{[car.volume_total, car.volume_available].join('\\')}"
        },
        route:
        lambda { |route, id|
          puts "Route ##{id} | Amount of stations: #{route.stations.length}"
          route.traverse(route.stations, &@output[:station])
        },
        type:
        lambda { |type, id|
          puts "#{id} - #{type.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')}"
        },
        parameter:
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
      puts "To go back to the previous menu type 'back', to quit - 'exit'"
      input = gets.chomp
      break if input == 'back'

      exit if input == 'exit'

      unless input.to_i.between?(1, actions.length)
        raise CustomException, 'Invalid action!'
      end

      puts 'Success!' if @calls[input.to_i][1].call
    end
  end

  def select_object(property, type = 'object', &block)
    raise CustomException, "No #{type}s found!" if property.empty?

    puts "Choose the #{type}:"
    property.each_with_index { |object, id| block.call(object, id + 1) }
    input = gets.chomp
    unless input.to_i.between?(1, property.length)
      raise CustomException, 'Invalid ID!'
    end

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
