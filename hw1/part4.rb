#!/usr/local/bin/ruby

=begin
(a) Create a Desert Class
=end
class Dessert
  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  attr_accessor :name
  attr_accessor :calories

  def healthy? ; self.calories < 200 ; end

  def delicious? ; true ; end
end


=begin
(b) Create a Jellybean Class
=end
class JellyBean < Dessert
  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  attr_accessor :flavor

  def delicious?
    return true unless self.flavor.downcase == "black licorice"
    false
  end
end
