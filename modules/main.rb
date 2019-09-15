# frozen_string_literal: true

require_relative 'train.rb'
require_relative 'passengertrain.rb'
require_relative 'cargotrain.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'railcar.rb'
require_relative 'passengercar.rb'
require_relative 'cargocar.rb'
require_relative 'interface/creator.rb'
require_relative 'interface/interaction.rb'
require_relative 'modules/manufacturer.rb'

master = Creator.new
main = Interaction.new(master)
main.start
