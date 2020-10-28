class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def del_intermediate_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.map { |station| puts station }
  end
end
