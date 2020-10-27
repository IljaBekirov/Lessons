index = 0
arr = [0, 1]
while index < 100
  index = arr.last(2).sum
  break if index > 100

  arr << index
end

puts arr.inspect
