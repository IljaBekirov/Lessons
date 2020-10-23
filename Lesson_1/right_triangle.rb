def sides(max, side_one, side_two)
  max_side_2 = (max**2).round(2)
  sum_sqr = (side_one**2 + side_two**2).round(2)
  {
    max_side: max,
    max_side_2: max_side_2,
    sum_sqr: sum_sqr
  }
end

print 'Введите сторону треугольника A: '
side_a = gets.chomp.to_f

print 'Введите сторону треугольника B: '
side_b = gets.chomp.to_f

print 'Введите сторону треугольника C: '
side_c = gets.chomp.to_f

hash = if side_a > side_b && side_a > side_c
         sides(side_a, side_b, side_c)
       elsif side_b > side_a && side_b > side_c
         sides(side_b, side_a, side_c)
       else
         sides(side_c, side_a, side_b)
       end

if side_a == side_b && side_b == side_c
  puts 'Треугольник является равносторонним'
end
if side_a == side_b || side_a == side_c || side_b == side_c
  puts 'Треугольник является равнобедренным'
end
puts 'Треугольник является прямоугольным' if hash[:max_side_2] == hash[:sum_sqr]
puts "Максимальная сторона равна #{hash[:max_side]}"
