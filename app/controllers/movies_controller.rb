class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @ordered_actors = @movie.actors_by_youngest
  end
end