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

  # Story 3
  # Add an Actor to a Movie

  # As a user,
  # When I visit a movie show page,
  # I do not see any actors listed that are not part of the movie
  # And I see a form to add an actor to this movie
  # When I fill in the form with the ID of an actor that exists in the database
  # And I click submit
  # Then I am redirected back to that movie's show page
  # And I see the actor's name is now listed
  # (You do not have to test for a sad path, for example if the id submitted is not an existing actor)

  describe 'As a user' do
    describe 'When I visit "/movies/:id' do
      before :each do
        @studio_1 = Studio.create(name: 'Universal Studios', location: 'Hollywood')
        @movie_1 = @studio_1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation, family')
        @actor_1 = Actor.create(name: 'Meryl Streep', age: 73)
        @actor_2 = Actor.create(name: 'Cidny Walker', age: 23)
        @actor_3 = Actor.create(name: 'Keanu Reeves', age: 302)
        @movie_1.actors << @actor_1

        visit "/movies/#{@movie_1.id}"
      end
      it 'I do not see any actors listed that are not part of the movie' do
        expect(page).to have_content(@actor_1.name)
        expect(page).to_not have_content(@actor_2.name)
        expect(page).to_not have_content(@actor_3.name)
      end

      it 'And I see a form to add an actor to this movie' do
        expect(page).to have_field('Actor ID')
      end

      describe 'When I fill in the form with the ID of an actor that exists in the database
      and I click submit' do
        it 'Then I am redirected back to that movies show page and
         I see the actors name is now listed' do
          fill_in('Actor ID', with: "#{@actor_2.id}")
          click_button('Add Actor')

          expect(current_path).to eq("/movies/#{@movie_1.id}")
          expect(page).to have_content(@actor_1.name)
          expect(page).to have_content(@actor_2.name)
          expect(page).to_not have_content(@actor_3.name)
        end
      end
    end
  end
end