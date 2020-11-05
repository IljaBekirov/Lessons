require './company_name'
require './instance_counter'

class Route
  include InstanceCounter
  include Validate
  # extend InstanceCounter::ClassMethods

  attr_accessor :stations

  @@routes = []

  def self.all
    @@routes
  end

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @@routes << self
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def del_intermediate_station(station)
    @stations.delete(station)
  end

  private

  def validate!
    raise 'Количество станций в маршруте не может быть меньше, чем 2' if stations.count < 2
  end
end
