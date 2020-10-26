print 'Введите число от 1 до 31: '
day = gets.chomp.to_i

print 'Введите месяц от 1 до 12: '
month = gets.chomp.to_i

print 'Введите год: '
year = gets.chomp.to_i

feb = if (year % 400).zero?
        29
      elsif (year % 100).zero?
        28
      elsif (year % 4).zero?
        29
      else 
        28
      end

months = {
  '1' => 31,
  '2' => feb,
  '3' => 31,
  '4' => 30,
  '5' => 31,
  '6' => 30,
  '7' => 31,
  '8' => 31,
  '9' => 30,
  '10' => 31,
  '11' => 30,
  '12' => 31
}



if month.to_i > 12
  puts "Ошибка. Количество месяцев в году 12, а не #{month}"
elsif months[month.to_s] < day
  puts "Ошибка. В этом месяце #{months[month.to_s]} дня(ей), а не #{day}"
else
  sum = 0
  i = 1
  until i == month
    sum += months[i.to_s]
    i += 1
  end

  sum += day
  puts sum
end
