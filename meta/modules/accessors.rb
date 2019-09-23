# frozen_string_literal: true

# :nodoc:
module Accessors
  module ClassMethods
    def attr_accessor_with_history(*args)
      raise CustomException, 'Attr_accessor arguments should be symbols!' unless args.all?(Symbol)

      args.each do |attr|
        define_method(attr) do
          instance_variable_get("@#{attr}")
        end
        define_method("#{attr}_history") do
          instance_variable_get("@#{attr}_history") || instance_variable_set("@#{attr}_history", [])
        end
        define_method("#{attr}=") do |value|
          instance_variable_get("@#{attr}_history")&.push(instance_variable_get("@#{attr}"))
          instance_variable_set("@#{attr}", value)
        end
      end
    end
  end

  def strong_attr_accessor(attr, type)
    define_method(attr) do
      instance_variable_get("@#{attr}")
    end
    define_method("#{attr}=") do |value|
      raise CustomException unless value.instance_of? type

      instance_variable_set("@#{attr}", value)
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end
end
