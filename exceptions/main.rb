# frozen_string_literal: true

require_relative 'classes/train.rb'
require_relative 'classes/passengertrain.rb'
require_relative 'classes/cargotrain.rb'
require_relative 'classes/route.rb'
require_relative 'classes/station.rb'
require_relative 'classes/railcar.rb'
require_relative 'classes/passengercar.rb'
require_relative 'classes/cargocar.rb'
require_relative 'interface/creator.rb'
require_relative 'interface/interaction.rb'
require_relative 'modules/manufacturer.rb'
require_relative 'modules/instancecounter.rb'

master = Creator.new
main = Interaction.new(master)
main.start
