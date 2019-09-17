# frozen_string_literal: true

require_relative 'train.rb'
require_relative 'passengertrain.rb'
require_relative 'cargotrain.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'railcar.rb'
require_relative 'passengercar.rb'
require_relative 'cargocar.rb'
require_relative 'creator.rb'
require_relative 'interaction.rb'

master = Creator.new
main = Interaction.new(master)
main.start
