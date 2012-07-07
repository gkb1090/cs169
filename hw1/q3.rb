#!/usr/local/bin/ruby

def combine_anagrams (words)

  arr = Array.new
  words.map { |w| w.downcase.split(//).sort.join}.each { |w|
    arr << w unless arr.include? w }

  arr_to_ret = Array.new(arr.length){[]}
  words.each { |w|
    arr_to_ret[arr.index(w.downcase.split(//).sort.join)] << w }
  arr_to_ret

end

print combine_anagrams (['CARS', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']) ; print "\n";
