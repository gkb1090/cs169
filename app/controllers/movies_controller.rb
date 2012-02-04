class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # use :ratings to set up all the ratings that have been checked
    @sort_type = params[:sort_by]

    if params[:ratings] == nil
      ratings_chckd = {}
    else
      ratings_chckd = params[:ratings].select{|k, v| v=="1" or v=="true"}
    end

    @all_ratings = Hash.new
    Movie.all_ratings.each do |r|
      @all_ratings[r]=ratings_chckd.has_key?(r)
      @all_ratings[r]=true if params[:ratings] == nil and
        !params.has_key?(:commit)
    end

    # handle the filtering
    if ratings_chckd.empty? and !params.has_key?(:commit)
      @movies = Movie.find(:all, :order => params[:sort_by])
    elsif ratings_chckd.empty?
      @movies = []
    else
      @movies = Movie.find_all_by_rating(ratings_chckd.keys,
                                         :order => params[:sort_by])
    end

    # conditionally set the class of title and release_date
    case params[:sort_by]
    when "title"
      @title_class = "hilite"
    when "release_date"
      @release_class = "hilite"
    end

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
