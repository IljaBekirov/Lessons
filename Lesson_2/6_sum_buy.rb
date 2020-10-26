basket = {}
loop do
  print 'Введите наименование товара: '
  name = gets.chomp

  if name.downcase == 'stop' || name.downcase == 'стоп'
    items = basket.values.map { |item| item[:sum] }
    if items.empty?
      puts 'Корзина пустая'
    else
      puts "Итого было куплено #{items.size} наименований(я) на общую сумму: #{items.sum}"
    end

    break
  end

  print 'Введите цену товара: '
  price = gets.chomp.to_f

  print 'Введите количество товара: '
  qnt = gets.chomp.to_f

  item = {
    name.to_s => {
      price: price,
      qnt: qnt,
      sum: price * qnt
    }
  }
  basket.merge!(item)

  puts basket
end
