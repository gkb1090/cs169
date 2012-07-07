require 'spec_helper'

describe MoviesController do
  describe 'searching by director' do

    before(:each) do
      @fake_movie = mock('movie1', :id => '0', :title =>'Star Wars', :director => 'George Lucas')
      @fake_results = [mock('Movie'), mock('Movie')]
      @fake_movie_no_director = mock('movie1', :id => '0', :title => 'Star Wars')
    end

    describe 'searching by director where a director exits' do

      it 'should call the model method that finds the movies' do
        Movie.should_receive(:find_by_id).with('0').and_return(@fake_movie)
        @fake_movie.should_receive(:director).and_return('George Lucas')
        Movie.should_receive(:find_similar).and_return(@fake_results)
        get :search_director, {:id => 0}
      end

      describe 'after retrieving all search results' do

        before :each do
          Movie.should_receive(:find_by_id).with('0').and_return(@fake_movie)
          @fake_movie.should_receive(:director).and_return('George Lucas')
          Movie.should_receive(:find_similar).and_return(@fake_results)
          get :search_director, {:id => 0}
        end

        it 'should select the Find By Director template for rendering' do
          response.should render_template('search_director')
        end

        it 'should make the movies found available to that template' do
          assigns(:movies).should == @fake_results
        end

        it 'should make the director available to that template' do
          assigns(:director).should == @fake_movie.director
        end

      end

      describe 'searching by director where a director doesn\'t exits' do

        it 'should redirect to the movies page' do
          Movie.should_receive(:find_by_id).with('0').and_return(@fake_movie_no_director)
          @fake_movie_no_director.should_receive(:director).and_return(nil)
          @fake_movie_no_director.should_receive(:title).and_return(@fake_movie_no_director.title)
          get :search_director, {:id => 0}
          response.should redirect_to(movies_path)
        end

      end

    end

  end
end
