class Movie < ActiveRecord::Base
  def self.all_ratings
    all(:group => "rating").map { |m| m.rating }
  end
end
