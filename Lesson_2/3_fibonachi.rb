index = 0
arr = []
while index < 100
  if arr.size < 2
    index += 1
  else
    index = arr[-1].to_i + arr[-2].to_i
    break if index > 100
  end
  arr << index
end

puts arr.inspect