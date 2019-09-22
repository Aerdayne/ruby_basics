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
require_relative 'interface/traincreator.rb'
require_relative 'interface/carcreator.rb'
require_relative 'interface/stationcreator.rb'
require_relative 'interface/routecreator.rb'
require_relative 'interface/interaction.rb'

require_relative 'modules/manufacturer.rb'
require_relative 'modules/instancecounter.rb'
require_relative 'modules/validation.rb'
require_relative 'modules/traverser.rb'
require_relative 'modules/accessors.rb'

require_relative 'exceptions/customexception.rb'

main = Interaction.new
main.start
