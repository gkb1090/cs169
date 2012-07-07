require 'spec_helper'

describe Movie do

  describe 'given the director, find all the movies by that director' do

    it 'should get a call to find similar movies and return those movies' do
      @fake_results = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('movie1', :id => '0', :title => 'Star Wars', :director => 'George Lucas')
      Movie.should_receive(:find_similar).with('George Lucas').and_return(@fake_results)
      Movie.find_similar @fake_movie.director
    end

  end

end
