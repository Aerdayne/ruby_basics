# frozen_string_literal: true

# :nodoc
class TrainCreator < Creator
  attr_reader :trains

  def initialize(creator)
    @creator = creator
    @calls = { 1 => ['Create a train', method(:new_train)],
               2 => ['Add cars', method(:add_cars)],
               3 => ['Remove cars', method(:remove_cars)],
               4 => ['Assign a route', method(:assign_route)],
               5 => ['Move a train', method(:move_train)],
               6 => ['List trains', method(:list_trains)] }
    @trains = []
    @train_types = [CargoTrain, PassengerTrain]
    @directions = %w[forwards backwards]
  end

  protected

  def new_train
    type = select_object(@train_types, 'type', &@creator.output[:parameter])
    puts 'Enter the train ID, format should be XXXXX or XXX-XX:'
    input = gets.chomp
    @trains << type.new(input)
  end

  def list_trains
    puts "\nTrains list:"
    list_objects(@trains, 'train', &@creator.output[:train])
  end

  def add_cars
    train = select_object(@trains, 'train', &@creator.output[:train])
    car = select_object(@creator.carcreator.cars, 'car', &@creator.output[:car])
    raise CustomException, 'Can not couple cars of a different type!' unless train.couple! car
  end

  def remove_cars
    train = select_object(@trains, 'train', &@creator.output[:train])
    car = select_object(train.cars, 'car', &@creator.output[:car])
    train.decouple! car
  end

  def assign_route
    train = select_object(@trains, 'train', &@creator.output[:train])
    route = select_object(@creator.routecreator.routes, 'route', &@creator.output[:route])
    train.assign_route! route
  end

  def move_train
    train = select_object(@trains, 'train', &@creator.output[:train])
    direction = select_object(@directions, 'directions', &@creator.output[:parameter])
    raise CustomException, 'Route is not set, or train is at the end-station!' unless train.move! direction
  end
end
