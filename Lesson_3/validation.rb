# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validates

    def validate(name, *args)
      @validates ||= []
      @validates << { name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |hash|
        hash.each { |name, args| send("validate_#{args[0]}", instance_variable_get("@#{name}"), *args[1]) }
      end
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(val)
      raise 'Значение не может быть пустым' if val.nil? || val.empty?
    end

    def validate_format(val, format)
      raise 'Не соответствует заданному формату' if val !~ format
    end

    def validate_type(val, type)
      raise 'Не соответствует заданному типу данных' unless val.is_a?(type)
    end
  end
end
