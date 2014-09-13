str = gets.chomp

def reverse(str)
  string = ''
  for i in (0...str.length)
    string << str[str.length-1 - i]
  end
  puts string
  puts string.size
  puts string.length
  puts string.size-1
  puts string.length-1
end

reverse(str)

