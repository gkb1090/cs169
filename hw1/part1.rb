#!/usr/local/bin/ruby

=begin
(a) Function to check if input string is a palindrome
=end
def palindrome? (string)
  vanilla_str = string.downcase.gsub(/[^a-z]/, '')
  vanilla_str.reverse == vanilla_str
end

=begin
(b) Function to return a word-count hash given an input string
=end
def count_words (string)
  h_to_ret = Hash.new
  string.downcase.scan(/\b\w+\b/).map do |word|
    h_to_ret[word] += 1 if h_to_ret.has_key?(word)
    h_to_ret[word] = 1 unless h_to_ret.has_key?(word)
  end
  h_to_ret
end

