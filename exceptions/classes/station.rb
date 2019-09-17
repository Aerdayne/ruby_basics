# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'

# :nodoc:
class Station
  attr_reader :trains, :name

  include Validation
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  @@stations = []

  def self.all
    @@stations
  end

  def list_specific(type)
    case type
    when 'passenger'
      @trains.select { |train| train.instance_of? PassengerTrain }
    when 'cargo'
      @train.select { |train| train.instance_of? CargoTrain }
    end
  end

  def host!(train)
    return unless train&.current == self

    @trains << train
    true
  end

  def depart!(train)
    return unless train&.current == self

    @trains.delete(train)
    true
  end

  protected

  def validate!
    raise CustomException, 'Name should be a string' unless @name.instance_of? String
    raise CustomException, 'Name should be at least 3 symbols long' if @name.length < 3
  end
end
