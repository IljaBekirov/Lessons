print 'Введите сторону треугольника A: '
side_a = gets.chomp.to_f

print 'Введите сторону треугольника B: '
side_b = gets.chomp.to_f

print 'Введите сторону треугольника C: '
side_c = gets.chomp.to_f

if side_a > side_b && side_a > side_c
  max_side = side_a
  max_side_2 = (max_side**2).round(2)
  sum_sqr = (side_b**2 + side_c**2).round(2)
elsif side_b > side_a && side_b > side_c
  max_side = side_b
  max_side_2 = (max_side**2).round(2)
  sum_sqr = (side_a**2 + side_c**2).round(2)
else
  max_side = side_c
  max_side_2 = (max_side**2).round(2)
  sum_sqr = (side_a**2 + side_b**2).round(2)
end

puts 'Треугольник является равносторонним' if side_a == side_b && side_b == side_c
puts 'Треугольник является равнобедренным' if side_a == side_b || side_a == side_c || side_b == side_c
puts 'Треугольник является прямоугольным' if max_side_2 == sum_sqr
puts "Максимальная сторона равна #{max_side}"
