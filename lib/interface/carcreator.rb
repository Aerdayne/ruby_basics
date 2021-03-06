# frozen_string_literal: true

# :nodoc:
class CarCreator < Creator
  attr_reader :cars

  def initialize(creator)
    @creator = creator
    @calls = { 1 => ['Create a car', method(:new_car)],
               2 => ['Load cars', method(:load_car)],
               3 => ['List cars', method(:list_cars)] }
    @cars = []
    @car_types = [CargoCar, PassengerCar]
  end

  def new_car
    type = select_object(@car_types, 'type', &@creator.output[:type])
    puts 'Enter the volume/seat capacity (or press ENTER to set the default value):'
    input = gets.chomp
    unless input =~ /^-?[0-9]+$/
      raise CustomException, "Capacity should be numeric!"
    end

    @cars << if input.empty?
               type.new
             else
               type.new(input.to_i)
             end
  end

  def load_car
    car = select_object(@cars, 'car', &@creator.output[:car])
    if car.instance_of? PassengerCar
      input = nil
    else
      puts 'Enter the volume to be occupied:'
      input = gets.chomp.to_i
    end
    raise CustomException, 'Volume is all used!' unless car.load!(*input)
  end

  def list_cars
    puts "\nCars list:"
    list_objects(@cars, 'car', &@creator.output[:car])
  end
end
