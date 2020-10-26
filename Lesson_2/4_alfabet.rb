letters = %w[a e o u i]

hash = {}
i = 1
('a'..'z').each do |letter|
  hash.merge!({ letter.to_s => i }) if letters.include?(letter)
  i += 1
end

puts hash
