data_hash = { start: 10, max: 100, step: 5 }

arr = []
while data_hash[:start] < data_hash[:max]
  arr << data_hash[:start]
  data_hash[:start] += data_hash[:step]
end
puts arr.inspect
