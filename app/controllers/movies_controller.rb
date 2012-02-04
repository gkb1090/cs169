class MoviesController < ApplicationController

  attr_accessor :ratings_chckd

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    ratings_chckd = {} if ratings_chckd == nil

    # handle the filtering
    if params[:ratings] != nil
      @movies = Movie.find_all_by_rating(params[:ratings].keys,
                                     {:order => params[:sort_by]})
    else
      @movies = Movie.all(:order => params[:sort_by])
    end

    # conditionally set the class of title and release_date
    case params[:sort_by]
    when "title"
      @title_class = "hilite"
    when "release_date"
      @release_class = "hilite"
    end

    @all_ratings = Movie.all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
