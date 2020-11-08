# frozen_string_literal: true

require './train'
require './station'
require './route'
require './cargo_train'
require './passenger_train'
require './wagon'
require './cargo_wagon'
require './passenger_wagon'
require './company_name'

def find_train(index)
  train_keys = Train.all.keys
  Train.all[train_keys[index - 1]]
end

def create_station
  print 'Введите название станции: '
  station = gets.chomp.to_s
  Station.new(station)
  show_all_stations
rescue RuntimeError => e
  show_error(e)
  retry
end

def show_all_stations
  puts '=====================Список всех станций====================|'
  Station.all.map.with_index(1) { |st, i| show_station(st, i) }
  puts '============================================================|'
end

def show_station(station, index)
  puts "#{index}) станция: #{station.name}, поездов: #{station.trains.count}"
end

def create_or_edit_train
  puts '1) Информация по поезду'
  puts '2) Создать новый поезд'
  variable = gets.chomp.to_i

  case variable
  when 1 then train_info
  when 2 then create_train
  else
    select_variant
  end
rescue RuntimeError => e
  show_error(e)
  retry
end

def train_info
  show_all_trains
  puts 'Выберите поезд для получения подробной информации'
  index = gets.chomp.to_i
  train = find_train(index)
  puts '1) Маршрут'
  puts '2) Вагоны'
  info = gets.chomp.to_i

  case info
  when 1 then show_route(train.route)
  when 2 then puts show_all_wagons_of_train(train)
  else
    select_variant
  end
  train
end

def create_train
  print 'Выберите тип поезда (1. Пассажирский, 2. Грузовой): '
  train_type = gets.chomp.to_i

  print 'Введите номер поезда: '
  train_number = gets.chomp.to_s
  train_type == 1 ? PassengerTrain.new(train_number) : CargoTrain.new(train_number)
  show_all_trains
end

def show_all_wagons_of_train(train)
  train.wagons.map.with_index(1) do |wag, i|
    if train.type == 'Cargo'
      "#{i}) Номер: #{wag.number} Общ объем: #{wag.volume} Занято: #{wag.occupied_volume} Свободно: #{wag.free_volume}"
    else
      "#{i}) Номер: #{wag.number} Кол-во мест: #{wag.seats} Занято: #{wag.occupied_seat} Свободно: #{wag.free_seats}"
    end
  end
end

def show_all_trains
  puts '=====================Список всех поездов====================|'
  Train.all.map.with_index(1) { |train, index| show_train(train, index) }
  puts '============================================================|'
end

def show_train(train, index)
  train = train.last
  name = train.station.nil? ? '' : "станция: #{train.station.name},"
  puts "#{index}) номер: #{train.number}, #{name} вагонов: #{train.wagons.count}, тип: #{train.type}"
end

def create_or_edit_route
  show_all_routes
  puts '1) Создание нового маршрута'
  puts '2) Редактирование существующего маршрута'
  number = gets.chomp.to_i

  case number
  when 1 then create_route
  when 2 then edit_routes
  else
    select_variant
  end
end

def edit_routes
  route = select_route

  puts '1) Добавить станцию в маршрут'
  puts '2) Удалить станцию из маршрута'
  number = gets.chomp.to_i
  case number
  when 1 then add_station(route)
  when 2 then del_station(route)
  else
    select_variant
  end

  show_all_routes
end

def select_route
  show_all_routes
  puts 'Выберите из списка маршрут для редактирования'
  i = gets.chomp.to_i
  Route.all[i - 1]
end

def add_station(route)
  show_all_stations
  puts 'Выберите станцию, которую хотите добавить в маршрут'
  st = gets.chomp.to_i
  route.add_intermediate_station(Station.all[st - 1])
end

def del_station(route)
  route.stations.map.with_index(1) { |station, ind| show_station(station, ind) }
  puts 'Выберите станцию которую хотите удалить из маршрут'
  st = gets.chomp.to_i
  route.del_intermediate_station(route.stations[st - 1])
end

def create_route
  show_all_stations
  error_station_count

  puts 'Выберите начальную станцию маршрута'
  i = gets.chomp.to_i
  start_station = Station.all[i - 1]

  puts 'Выберите конечную станцию маршрута'
  n = gets.chomp.to_i
  end_station = Station.all[n - 1]

  Route.new(start_station, end_station)
  show_all_routes
end

def error_station_count
  return unless Station.all.count < 2

  puts '============================================================|'
  puts 'Ошибка! Нет возможности создать маршрут из одной станции!'
  puts '============================================================|'
end

def show_all_routes
  puts '=====================Список всех маршрутов==================|'
  Route.all.map.with_index(1) { |route, index| show_route(route, index) }
  puts '============================================================|'
end

def show_route(route, index = 1)
  puts "#{index}) станции маршрута: #{route.stations.map(&:name)}"
end

def add_route_to_train
  puts 'Выберите поезд которому хотите добавить маршрут'
  show_all_trains
  train = gets.chomp.to_i

  puts 'Выберите маршрут, который хотите добавить данному поезду'
  show_all_routes
  route = gets.chomp.to_i
  find_train(train).add_routes(Route.all[route - 1])
  show_all_trains
end

def create_or_edit_wagon
  puts 'Выберите поезд вагонами которого хотите управлять'
  show_all_trains
  train_index = gets.chomp.to_i

  train = find_train(train_index)

  puts '1) Прицепить вагон'
  puts '2) Отцепить вагон'
  action = gets.chomp.to_i
  case action
  when 1 then add_wagon(train)
  when 2 then train.del_wagons
  else
    select_variant
  end
rescue StandardError => e
  puts e
end

def add_wagon(train)
  wagon = if train.type == 'Cargo'
            print 'Введите общий объем вагона: '
            vol = gets.chomp.to_i
            CargoWagon.new(vol)
          else
            print 'Введите номер вагона: '
            number = gets.chomp.to_i

            print 'Введите общее количество мест в вагоне: '
            seats = gets.chomp.to_i
            PassengerWagon.new(number, seats)
          end
  train.add_wagons(wagon)
end

def move_train
  puts 'Выберите поезд который хотите перемещать'
  show_all_trains
  train_index = gets.chomp.to_i

  train = find_train(train_index)

  puts '1) Переместить поезд вперёд по маршруту'
  puts '2) Переместить поезд назад по маршруту'
  action = gets.chomp.to_i

  case action
  when 1 then train.go_forvard
  when 2 then train.go_back
  else
    select_variant
  end

  show_all_trains
rescue RuntimeError => e
  show_error(e)
  retry
end

def select_variant
  puts 'Выберите один из вариантов'
end

def show_error(error)
  puts '=======================Ошибка===============================|'
  puts error.message
  puts '============================================================|'
end

loop do
  puts '============================================================|'
  puts '-----------Программа управления Железной дорогой------------|'
  puts '============================================================|'
  puts '1) Создание станции                                         |'
  puts '2) Создание и управление поездами                           |'
  puts '3) Создание и управление маршрутами                         |'
  puts '4) Назначение маршрута поезду                               |'
  puts '5) Упрвление вагонами                                       |'
  puts '6) Перемещение поезда по маршруту                           |'
  puts '7) Просмотр списка станций и списка поездов                 |'
  puts '------------------------------------------------------------|'
  puts '-----------------Для выхода введите 0-----------------------|'
  puts '============================================================|'
  command = gets.chomp.to_i

  case command
  when 0 then break
  when 1 then create_station
  when 2 then create_or_edit_train
  when 3 then create_or_edit_route
  when 4 then add_route_to_train
  when 5 then create_or_edit_wagon
  when 6 then move_train
  when 7 then show_all_stations
  else
    puts 'Выберите номер из списка'
  end
end
