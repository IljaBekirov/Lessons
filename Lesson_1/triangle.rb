print 'Enter base of triangle: '
base = gets.chomp.to_f

print 'Enter height of triangle: '
height = gets.chomp.to_f

area = (base * height / 2.0).round(2)

puts "Area of triangle is #{area}"
