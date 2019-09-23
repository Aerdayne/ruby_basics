# frozen_string_literal: true

# :nodoc:
module Validation
  module ClassMethods
    attr_reader :validators

    def validate(attribute, type, *args)
      raise CustomException, 'Attribute to be validated should be a symbol!' unless [attribute, type].all?(Symbol)

      @validators ||= []
      @validators << { attribute_name: attribute, validation_call: type, arguments: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validators.each do |row|
        value = instance_variable_get("@#{row[:attribute_name]}")
        Validation.send row[:validation_call], row[:attribute_name], value, row[:arguments]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  class << self
    def presence(attribute, value, *_args)
      raise CustomException, "#{attribute} can't be nil or empty!" if value.nil? || value == ''
    end

    def format(attribute, value, args)
      pattern = args[0]
      raise CustomException, "#{attribute} doesn't match the permitted pattern!" unless value =~ pattern
    end

    def type(attribute, value, args)
      type = args[0]
      raise CustomException, "#{attribute} can only be a #{type}!" unless value.instance_of? type
    end

    def range(attribute, value, range)
      if value.instance_of? String
        raise CustomException, "#{attribute} should be not shorter than #{range[0]} letters!" unless value.length > range[0]
      else
        min = range[0]
        max = range[1]
        raise CustomException, "#{attribute} should be in range [#{min}, #{max}]!" unless value.between?(min, max)
      end
    end

    def route_validity(attribute, value, *_args)
      raise CustomException, "Route #{attribute} should consist of stations!" unless value.all?(Station)
      raise CustomException, 'Route departure and destination can not be the same!' if value[0] == value[-1]
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end
