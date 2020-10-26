index = 0
arr = []
while index < 100
  if arr.size < 2
    index += 1
  else
    index = arr.last(2).sum
    break if index > 100
  end
  arr << index
end

puts arr.inspect
