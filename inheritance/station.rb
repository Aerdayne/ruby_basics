# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def list_specififc(type)
    @trains.select { |train| train.type == type }
  end

  def host!(train)
    @trains << train
  end

  def depart!(train)
    @trains.delete(train)
  end
end
