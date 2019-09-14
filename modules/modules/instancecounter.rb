# frozen_string_literal: true

# :nodoc:
module InstanceCounter
  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    def initialize(*args)
      super
      register_instance
    end

    protected

    def register_instance
      self.class.instances += 1
    end
  end

  # Prepend hook to overrtide Class#Initialize
  def self.prepended(base)
    class << base
      include InstanceMethods
    end
  end
end
