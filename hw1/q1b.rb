#!/usr/local/bin/ruby

# Given a string of input, return a hash whose keys are words in the string
# and whose values are the number of times each word appears

def count_words (string)
  h_to_ret = Hash.new
  string.downcase.scan(/\b\w+\b/).map do |word|
    h_to_ret[word] += 1 if h_to_ret.has_key?(word)
    h_to_ret[word] = 1 unless h_to_ret.has_key?(word)
  end
  h_to_ret
end

puts count_words ("A man, a plan, a canal -- Panama")
puts count_words ("Doo bee doo bee doo")
