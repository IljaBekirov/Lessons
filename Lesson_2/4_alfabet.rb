letters = %w[a e o u i]

hash = {}
('a'..'z').each.with_index(1) do |letter, i|
  hash.merge!({ letter.to_s => i }) if letters.include?(letter)
end

puts hash
