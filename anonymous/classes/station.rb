# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'
require_relative '../modules/traverser.rb'

# :nodoc:
class Station
  attr_reader :trains, :name

  include Traverser
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
    @trains.select { |train| train.instance_of? type }
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
