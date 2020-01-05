# frozen_string_literal: true

# :nodoc:
module Validation
  module ClassMethods
    attr_reader :validators

    def validate(attribute, type, *args)
      unless [attribute, type].all?(Symbol)
        raise CustomException, 'Attribute to be validated should be a symbol!'
      end

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
      if value.nil? || value == ''
        raise CustomException, "#{attribute} can't be nil or empty!"
      end
    end

    def format(attribute, value, args)
      pattern = args[0]
      unless value =~ pattern
        raise CustomException, "#{attribute} doesn't match the permitted pattern!"
      end
    end

    def type(attribute, value, args)
      klass = args[0]
      unless value.instance_of? klass
        raise CustomException, "#{attribute} can only be a #{klass}!"
      end
    end

    def range(attribute, value, range)
      if value.instance_of? String
        unless value.length > range[0]
          raise CustomException, "#{attribute} should be not shorter than #{range[0]} letters!"
        end
      else
        min = range[0]
        max = range[1]
        unless value.between?(min, max)
          raise CustomException, "#{attribute} should be in range [#{min}, #{max}]!"
        end
      end
    end

    def route_validity(attribute, value, *_args)
      unless value.all?(Station)
        raise CustomException, "Route #{attribute} should consist of stations!"
      end
      if value[0] == value[-1]
        raise CustomException, 'Route departure and destination can not be the same!'
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end
