# frozen_string_literal: true

require './company_name'
require './instance_counter'
require './validation'
require './accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors
  # extend InstanceCounter::ClassMethods

  attr_accessor_with_history :attr_method
  strong_attr_accessor(:string, String)

  STATION = /[a-zа-яA-ZА-Я]{2,}|\d/.freeze

  attr_accessor :trains
  attr_reader :name
  validate :name, :presence
  validate :name, :format, STATION
  validate :name, :type, String

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end

  def train_block(&block)
    @trains.each(&block) if block_given?
  end
end
