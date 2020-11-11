# frozen_string_literal: true

require './company_name'
require './instance_counter'
require './validation'

class Route
  include InstanceCounter
  include Validation
  # extend InstanceCounter::ClassMethods

  STATION = /[a-zа-яA-ZА-Я]{2,}|\d/.freeze

  attr_accessor :stations
  attr_reader :start_station, :end_station

  validate :start_station, :presence
  validate :start_station, :format, STATION
  validate :start_station, :type, String
  validate :end_station, :presence
  validate :end_station, :format, STATION
  validate :end_station, :type, String
  validate :stations, :type, Array

  @@routes = []

  def self.all
    @@routes
  end

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
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
end
