class MovieActorsController < ApplicationController
  def create
    # require 'pry'; binding.pry
    movie = Movie.find(params[:movie_id])
    new_actor = Actor.find(params[:actor_id])
    movie.actors << new_actor
    redirect_to "/movies/#{params[:movie_id]}"
  end
end