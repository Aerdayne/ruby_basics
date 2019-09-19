# frozen_string_literal: true

# :nodoc:
class CarCreator < Creator
  attr_reader :cars

  def initialize(creator)
    @creator = creator
    @calls = { 1 => ['Create a car', method(:new_car)],
               2 => ['List cars', method(:list_cars)] }
    @cars = []
    @car_types = [CargoCar, PassengerCar]
  end

  def new_car
    type = select_object(@car_types, 'type', &@creator.output_formats[:parameter_output])
    puts 'Enter the volume/seat capacity (or press ENTER to set the default value):'
    input = gets.chomp
    @cars << if input.empty?
               type.new
             else
               type.new(input.to_i)
             end
  end

  def list_cars
    puts "\nCars list:"
    list_objects(@cars, 'car', &@creator.output_formats[:car_output])
  end
end
