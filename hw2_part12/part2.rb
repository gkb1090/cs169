#!/usr/local/bin/ruby

=begin
Implement Cartesian Product
=end

class CartesianProduct
  include Enumerable
  # instance variable to maintain cartesian product
  def initialize (seq1, seq2)
    @product = Array.new
    seq1.each { |elt1| seq2.each { |elt2| @product << [elt1, elt2] } }
  end

  attr_accessor :product

  # each method to make this class Enumerable
  def each
    return product.each unless block_given?
    product.each { |elt| yield elt }
  end
end
