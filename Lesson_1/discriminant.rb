puts 'Квадратное алгебраическое уравнение имеет вид: ах^2 + bx + c = 0'

print "Введите коэффициент 'a': "
coef_a = gets.chomp.to_f

print "Введите коэффициент 'b': "
coef_b = gets.chomp.to_f

print "Введите коэффициент 'c': "
coef_c = gets.chomp.to_f

puts 'Дискриминант вывычисляется по формуле: D = b^2 – 4ac'

d = coef_b**2 - 4 * coef_a * coef_c

if d.positive?
  math_sqrt = Math.sqrt(d)
  x_1 = ((- coef_b + math_sqrt) / 2 * coef_a).round(2)
  x_2 = ((- coef_b - math_sqrt) / 2 * coef_a).round(2)

  puts "Коэффициент Х1 = #{x_1}"
  puts "Коэффициент Х2 = #{x_2}"
  puts "Дискриминант равен: #{d}"
elsif d.zero?
  x_1 = ((- coef_b) / 2 * coef_a).round(2)

  puts "Коэффициент Х = #{x_1}"
  puts "Дискриминант равен: #{d}"
else
  puts 'Корней нет'
end
