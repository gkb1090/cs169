class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  # INSTANCE VARIABLES IN INDEX:
  # @sort_type - dictactes what column we are sorting by
  # @all_ratings - returns hash of {rating => checked?} for all ratings in the DB
  # @movies - all the movies after filter and sort applied
  #
  # ASSUMED CONTENT IN PARAMS[]:
  # params[:sort_by] => string representing what column to sort movies by
  # params[:commit]  => its presence indicates that "Refresh" was clicked
  # params[:ratings] => a hash of {rating => checked?} where checked? is a string
  #                     If a rating doesn't appear in  hash, assume chckd?=false
  def index
    # if the session has something :to_remember and neither the Refresh button
    # not a sort were requested, then it cannot be the first time you are coming
    # to the website. In this case, redirect_to a movies_path with the rememberd
    # params and remove the :to_remember from session.
    if session.has_key?(:to_remember) and
        !(params.has_key?(:commit) or params.has_key?(:sort_by))
      flash[:notice] = flash[:notice]
      redirect_to movies_path(session[:to_remember])
    end

    # ASSUMING that if redirect_to was reached, then you won't get to this part
    # of the program, you need to delete the :to_remember key from the session
    session.delete(:to_remember)

    @sort_type = params[:sort_by] # get what column to sort by

    # get all the ratings that have been checked
    # if no ratings were checked, ratings_chckd will be {}
    ratings_chckd = Hash.new
    ratings_chckd = params[:ratings].select{|k, v| v=="true"} unless
      params[:ratings] == nil

    # obtain all the ratings using Movie.all_ratings and set all to true
    @all_ratings = Hash.new
    Movie.all_ratings.each { |r| @all_ratings[r] = true }

    # first check if "Refresh" was clicked or a sort was requested
    if params.has_key?(:commit) or params.has_key?(:sort_by)
      # if yes, @all_ratings should have true values for only those ratings
      # that are checked. This will ensure that what was clicked stays clicked.
      Movie.all_ratings.each { |r| @all_ratings[r] = ratings_chckd.has_key?(r) }

      # return @movies after filtering by ratings that have been checked
      @movies = Movie.find_all_by_rating(ratings_chckd.keys,
                                         :order => @sort_type)
      # the previous statement finds all if there are no ratings checked so
      # handle that here explicitly
      @movies = [] if ratings_chckd.empty?

      # the to_remember key in session[] has value of params
      # important that we only add it if we actually sorted or filtered
      session[:to_remember] = params

    else
      # first entry upon website. Here we want all movies to appear and all
      # ratings in @all_ratings to be true so that they are all checked
      @movies = Movie.all
    end

    # conditionally set the class of title and release_date
    case @sort_type
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
    logger.debug "When creating we have #{flash[:notice]} "
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
