# frozen_string_literal: true

# :nodoc:
class Station
  prepend Accessors
  prepend InstanceCounter

  include Validation
  include Traverser

  attr_accessor_with_history :trains, :name

  validate :name, :presence
  validate :name, :type, String
  validate :name, :range, 3

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
end
