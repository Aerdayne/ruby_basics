# frozen_string_literal: true

# :nodoc:
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
    return if train.nil?

    @trains << train if train.current == self
  end

  def depart!(train)
    return if train.nil?

    @trains.delete(train) if train.current == self
  end
end
