#!/usr/local/bin/ruby

def palindrome? (string)
  vanilla_str = string.downcase.gsub(/[^a-z]/, '')
  vanilla_str.reverse == vanilla_str
end

puts palindrome?("A man, a plan, a canal -- Panama")
puts palindrome?("Madam, I'm Adam!")
puts palindrome?("Abracadabra")
puts palindrome?("Rats live. on no evil! star")
