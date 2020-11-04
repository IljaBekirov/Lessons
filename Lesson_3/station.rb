require './company_name'
require './instance_counter'

class Station
  include InstanceCounter
  # extend InstanceCounter::ClassMethods

  STATION = /[a-zа-я]{2,}|\d/i.freeze

  attr_accessor :trains
  attr_reader :name

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

  private

  def validate?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Станция не соответствует требованиям' if name !~ STATION
  end
end
