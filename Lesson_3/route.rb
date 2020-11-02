require './company_name'
require './instance_counter'

class Route
  include InstanceCounter
  # extend InstanceCounter::ClassMethods

  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def del_intermediate_station(station)
    @stations.delete(station)
  end
end
