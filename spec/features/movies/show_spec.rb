require 'rails_helper'
# Story 2
# Movie Show

# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors

RSpec.describe 'movies show page' do
  describe 'As a user' do
    describe 'When I visit "/movies/:id' do
      before :each do
        @studio_1 = Studio.create(name: 'Universal Studios', location: 'Hollywood')
        @movie_1 = @studio_1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation, family')
        @actor_1 = Actor.create(name: 'Meryl Streep', age: 73)
        @actor_2 = Actor.create(name: 'Cidny Walker', age: 23)
        @actor_3 = Actor.create(name: 'Keanu Reeves', age: 302)
        @movie_1.actors << @actor_1
        @movie_1.actors << @actor_2
        @movie_1.actors << @actor_3

        visit "/movies/#{@movie_1.id}"
      end

      it "I see the movie's title, creation year, and genre" do
        expect(page).to have_content(@movie_1.title)
        expect(page).to have_content(@movie_1.creation_year)
        expect(page).to have_content(@movie_1.genre)
      end

      it "And a list of all its actors from youngest to oldest" do
        expect(@actor_2.name).to appear_before(@actor_1.name)
        expect(@actor_1.name).to appear_before(@actor_3.name)
      end

      it "And I see the average age of all of the movie's actors" do
        expect(page).to have_content("Average Actor's Age: 132.667")
      end
    end
  end
end