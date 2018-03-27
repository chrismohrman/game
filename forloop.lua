dog = {
  {'a', 'b', 'c', 'd'},
  {'a', 'b', 'c', 'd'},
  {'a', 'b', 'c', 'd'},
  {'a', 'b', 'c', 'd'}
  }
for index in ipairs(dog) do
  local value = dog[index]
  print(value)

  for letterindex in ipairs(value) do
    local letter = value[letterindex]
    print (letter)
  end

end
