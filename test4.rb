zdanie = gets.chomp

zdanie2 = zdanie.split ""

def reverse(zdanie2, zdanie)
  for i in 1..zdanie.length
  result = ""
  result << zdanie2[zdanie.length - i]
  print result
  end

end

 reverse(zdanie2, zdanie)