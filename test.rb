

def number_hash
  {"M": 1000,
    "D": 500,
    "C": 100,
    "L": 50,
    "X": 10,
    "V": 5,
    "I": 1}
end


def to_roman(num)
    result = ''
    number_hash.each do |key, value|
      while num >= value
        result += key.to_s
        num -= value
      end
    end
    result
end


puts 'case 1 failed' if to_roman(128) != 'CXXVIII'
puts 'case 2 failed' if to_roman(2000) != 'MM'
puts 'case 3 failed' if to_roman(2017) != 'MMXVII'
require 'pry'; binding.pry
puts 'case 4 failed' if to_roman(1999) != 'MCMXCIX'
