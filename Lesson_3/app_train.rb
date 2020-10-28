require './train'
require './station'
require './route'

train = Train.new('10', 'pass', 23)
train_2 = Train.new('980', 'cargo', 43)

station_1 = Station.new('Sevastopol')
station_2 = Station.new('Saint-Petersburg')
station_3 = Station.new('Rostov-on-Don')
station_4 = Station.new('Belgorod')

route = Route.new(station_1, station_2)

route.add_intermediate_station(station_3)
route.add_intermediate_station(station_4)

train.add_routes(route)
train.station
train.go_forvard
train.next_station
train.next_station
train.previous_station

station_1.train_arrival(train)
station_1.train_arrival(train_2)
station_1.train_departure(train_2)
station_1.all_trains('pass')
station_1.all_trains('cargo')

route.add_intermediate_station(station_3)
route.add_intermediate_station(station_4)
route.del_intermediate_station(station_4)
route.show_stations

train.speed_up(10)
train.speed_down(10)
train.speed_stop
train.wagons
train.add_wagons(4)
train.del_wagons(4)

# train.add_routes(route)
