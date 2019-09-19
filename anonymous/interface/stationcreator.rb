# frozen_string_literal: true

# :nodoc
class StationCreator < Creator
  attr_reader :stations

  def initialize(creator)
    @creator = creator
    @calls = { 1 => ['Create a station', method(:new_station)],
               2 => ['List stations', method(:list_stations)] }
    @stations = []
  end

  def new_station
    puts 'Enter the station name, length should be at least 3 symbols long:'
    input = gets.chomp
    @stations << Station.new(input)
  end

  def list_stations
    puts 'Stations list:'
    list_objects(@stations, 'station', &@creator.output_formats[:station_output])
  end
end
