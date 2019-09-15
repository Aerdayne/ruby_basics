# frozen_string_literal: true

require_relative '../modules/instancecounter.rb'
require_relative '../modules/validation.rb'
require_relative '../exceptions/argumenttypeerror.rb'
require_relative '../exceptions/traintypeerror.rb'
require_relative '../exceptions/duplicateobjecterror.rb'
require_relative '../exceptions/objectintegrityerror.rb'
# :nodoc:
class Station
  attr_reader :trains, :name

  include Validation
  extend InstanceCounter::ClassMethods
  prepend InstanceCounter::InstanceMethods

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
  end

  @@stations = []

  def self.all
    @@stations
  end

  def list_specific(type)
    validate! :list_specific, type
    case type
    when 'passenger'
      @trains.select { |train| train.instance_of? PassengerTrain }
    when 'cargo'
      @trains.select { |train| train.instance_of? CargoTrain }
    end
  end

  def host!(train)
    validate! :host!, train
    @trains << train
  end

  def depart!(train)
    validate! :depart!, train
    @trains.delete train
  end

  protected

  def validate!(*args)
    # Station#Initialize validation
    raise ArgumentTypeError unless @name.instance_of?(String)

    # Method validation
    unless args.empty?
      case args[0]
      when :host!, :depart!
        raise ArgumentTypeError unless args[1].is_a?(Train)
        raise ObjectIntegrityError unless args[1].current == self
        raise DuplicateObjectError if @trains.include? args[1]
      when :list_specific
        raise TrainTypeError unless Train.train_types.include?(args[1])
      end
    end
  end
end
