class Movie < ActiveRecord::Base
  def self.all_ratings
    find(:all, :select => "rating", :group => "rating").map { |m| m.rating }
  end
end
