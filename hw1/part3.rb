#!/usr/local/bin/ruby

=begin
Given an array of words, group them into anagram groups
=end

def combine_anagrams (words)

  arr = Array.new
  words.map { |w| w.downcase.split(//).sort.join}.each { |w|
    arr << w unless arr.include? w }

  arr_to_ret = Array.new(arr.length){[]}
  words.each { |w|
    arr_to_ret[arr.index(w.downcase.split(//).sort.join)] << w }
  arr_to_ret

end
