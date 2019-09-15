# frozen_string_literal: true

require_relative 'modules/instancecounter.rb'
# :nodoc:
class Station
  attr_reader :trains, :name

  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  @@stations = []

  def self.all
    @@stations
  end

  def list_specififc(type)
    case type
    when 'passenger'
      @trains.select { |train| train.instance_of? PassengerTrain }
    when 'cargo'
      @train.select { |train| train.instance_of? CargoTrain }
    end
  end

  def host!(train)
    return if train.nil?

    @trains << train if train.current == self
  end

  def depart!(train)
    return if train.nil?

    @trains.delete(train) if train.current == self
  end
end
