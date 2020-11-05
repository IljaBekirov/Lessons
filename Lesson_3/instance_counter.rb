# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    # private

    def plus_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    # private

    def register_instance
      self.class.plus_instance
    end
  end
end
