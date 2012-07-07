#!/usr/local/bin/ruby

=begin
(a) add the "in" method to Numeric class to allow for things like 5.euro.in(:rupees)
=end

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def in (currency); self / @@currencies[currency.to_s.gsub(/s$/, '')]; end
end

=begin
(b) Use palindrome? to turn palindrome?("foo") to "foo".palindrome?
=end
module Utils
  def self.palindrome? (string)
    vanilla_str = string.downcase.gsub(/[^a-z0-9]/, '')
    vanilla_str.reverse == vanilla_str
  end
end

class String
  include Utils

  def palindrome?
    Utils.palindrome?(self)
  end
end

=begin
(c) Make palindrome? work on enumerables
=end

=begin
module Enumerable
  include Utils
  def palindrome?
    record = ''
    self.each { |elt| record = record + elt.to_s }
    Utils.palindrome? (record)
  end
end
=end

module Enumerable
  def palindrome?
    rvrsd = self.reverse_each
    self.each { |elt| return false if rvrsd.next != elt }
    return true
  end
end
