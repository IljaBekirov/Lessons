# frozen_string_literal: true

require './company_name'
require './instance_counter'
require './validation'

class Train
  include CompanyName
  include InstanceCounter
  include Validation
  # extend InstanceCounter::ClassMethods

  TRAIN_NUMBER = /\w{3}-\w{2}|\w{5}/.freeze

  @@trains = {}

  def self.find(train_number)
    @@trains[train_number]
  end

  def self.all
    @@trains
  end

  attr_accessor :speed, :route, :station, :wagons
  attr_reader :number

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER
  validate :number, :type, String

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains.merge!(number.to_s => self)
    # register_instance
  end

  def add_wagons(wagon)
    raise 'Данному типу поезда не подходит этот тип вагона' unless wagon.class.to_s.include?(type)

    unless speed.zero?
      raise "Поезд движется со скоростью #{speed}. Прицеплять вагоны разрешено только к стоящему поезду"
    end

    @wagons << wagon
    puts "В состав добавили вагон, итого #{@wagons.count} вагон(ов)"
  end

  def del_wagons
    raise "Поезд движется со скоростью #{speed}. Отцеплять вагон разрешено только от стоящего поезда" unless speed.zero?

    raise 'В составе нет ни одного вагона' if @wagons.count.zero?

    @wagons.delete_at(-1)
    puts "Из состава убрали вагон, итого #{@wagons.count} вагонов"
  end

  def add_routes(route)
    @index_station = 0
    @route = route
    @station = @route.stations[@index_station]
    @station.train_arrival(self)
  end

  def go_forvard
    return next_station unless next_station

    @station.train_departure(self)
    @station = @route.stations[@index_station += 1]
    @station.train_arrival(self)
  end

  def go_back
    return previous_station unless previous_station

    @station.train_departure(self)
    @station = @route.stations[@index_station -= 1]
    @station.train_arrival(self)
  end

  def wagons_block(&block)
    @wagons.each(&block) if block_given?
  end

  private

  def previous_station
    raise 'Это первая станция в маршруте, предыдущей станции нет' if (@index_station - 1).negative?

    true
  end

  def next_station
    raise 'Это конечная станция в маршруте' if @route.stations.size - 1 < @index_station + 1

    true
  end
end
