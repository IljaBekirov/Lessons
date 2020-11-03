require './train'
require './station'
require './route'
require './cargo_train'
require './passenger_train'
require './wagon'
require './cargo_wagon'
require './passenger_wagon'
require './company_name'

@trains = []
@routes = []

def create_station
  print 'Введите название станции: '
  station = gets.chomp.to_s
  Station.new(station)
  show_all_stations
end

def show_all_stations
  all_stations = Station.stations.map.with_index do |st, i|
    "#{i + 1}) станция: #{st.name}, поездов: #{st.trains.count}"
  end
  puts '=====================Список всех станций====================|'
  puts all_stations
  puts '============================================================|'
end

def create_train
  print 'Выберите тип поезда (1. Пассажирский, 2. Грузовой): '
  train_type = gets.chomp.to_i

  print 'Введите номер поезда: '
  train_number = gets.chomp.to_s
  if train_number.empty? || train_type.nil?
    puts '============================================================|'
    puts '----------------Введите тип и номер поезда------------------|'
    puts '============================================================|'
    return
  end
  @trains << (train_type == 1 ? PassengerTrain.new(train_number) : CargoTrain.new(train_number))

  show_all_trains
end

def show_all_trains
  all_trains = @trains.map.with_index do |tr, i|
    name = tr.station.nil? ? '' : "станция: #{tr.station.name},"
    "#{i + 1}) номер: #{tr.number}, #{name} вагонов: #{tr.wagons.count}, тип: #{tr.type}"
  end
  puts '=====================Список всех поездов====================|'
  puts all_trains
  puts '============================================================|'
end

def create_or_edit_route
  show_all_routes
  puts '1) Создание нового маршрута'
  puts '2) Редактирование существующего маршрута'
  n = gets.chomp.to_i

  if n == 1
    create_route
  elsif n == 2
    edit_routes
  end
end

def edit_routes
  show_all_routes
  puts 'Выберите из списка маршрут для редактирования'
  i = gets.chomp.to_i
  route = @routes[i - 1]

  puts '1) Добавить станцию в маршрут'
  puts '2) Удалить станцию из маршрута'
  n = gets.chomp.to_i
  if n == 1
    show_all_stations
    puts 'Выберите станцию, которую хотите добавить в маршрут'
    st = gets.chomp.to_i
    route.add_intermediate_station(Station.stations[st - 1])
  elsif n == 2
    stations = route.stations.map.with_index do |station, ind|
      "#{ind + 1}) станция: #{station.name}"
    end
    puts stations
    puts 'Выберите станцию которую хотите удалить из маршрут'
    st = gets.chomp.to_i
    route.del_intermediate_station(route.stations[st - 1])
  end
  show_all_routes
end

def create_route
  show_all_stations
  if Station.stations.count < 2
    puts '============================================================|'
    puts 'Ошибка! Нет возможности создать маршрут из одной станции!'
    puts '============================================================|'
    return
  end

  puts 'Выберите начальную станцию маршрута'
  i = gets.chomp.to_i
  start_station = Station.stations[i - 1]

  puts 'Выберите конечную станцию маршрута'
  n = gets.chomp.to_i
  end_station = Station.stations[n - 1]

  @routes << Route.new(start_station, end_station)
  show_all_routes
end

def show_all_routes
  all_routes = @routes.map.with_index do |route, i|
    "#{i + 1}) станции маршрута: #{route.stations.map(&:name)}"
  end
  puts '=====================Список всех маршрутов==================|'
  puts all_routes
  puts '============================================================|'
end

def add_route_to_train
  puts 'Выберите поезд которому хотите добавить маршрут'
  show_all_trains
  train = gets.chomp.to_i
  puts 'Выберите маршрут, который хотите добавить данному поезду'
  show_all_routes
  route = gets.chomp.to_i
  @trains[train - 1].add_routes(@routes[route - 1])
  show_all_trains
end

def create_or_edit_wagon
  puts 'Выберите поезд вагонами которого хотите управлять'
  show_all_trains
  train_index = gets.chomp.to_i
  train = @trains[train_index - 1]

  puts '1) Прицепить вагон'
  puts '2) Отцепить вагон'
  action = gets.chomp.to_i
  if action == 1
    wagon = (train.type == 'Cargo' ? CargoWagon.new : PassengerWagon.new)
    train.add_wagons(wagon)
  elsif action == 2
    train.del_wagons
  end
end

def move_train
  puts 'Выберите поезд который хотите перемещать'
  show_all_trains
  train_index = gets.chomp.to_i
  train = @trains[train_index - 1]

  puts '1) Переместить поезд вперёд по маршруту'
  puts '2) Переместить поезд назад по маршруту'
  action = gets.chomp.to_i
  if action == 1
    train.go_forvard
  elsif action == 2
    train.go_back
  end

  show_all_trains
end

loop do
  puts '============================================================|'
  puts '-----------Программа управления Железной дорогой------------|'
  puts '============================================================|'
  puts '1) Создание станции                                         |'
  puts '2) Создание поезда                                          |'
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
  when 2 then create_train
  when 3 then create_or_edit_route
  when 4 then add_route_to_train
  when 5 then create_or_edit_wagon
  when 6 then move_train
  when 7 then show_all_stations
  else
    puts 'Выберите номер из списка'
  end
end
