# frozen_string_literal: true

# :nodoc:
module Accessors
  module ClassMethods
    def attr_accessor_with_history(*args)
      raise CustomException, 'Attr_accessor arguments should be symbols!' unless args.all? { |arg| arg.instance_of? Symbol }

      args.each do |method|
        define_method(method) do
          instance_variable_get("@#{method}")
        end
        define_method("#{method}_history") do
          instance_variable_get("@#{method}_history") || instance_variable_set("@#{method}_history", [])
        end
        define_method("#{method}=".to_sym) do |value|
          instance_variable_set("@#{method}", value)
          send :"#{method}_history"
          instance_variable_get("@#{method}_history").push(value)
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
