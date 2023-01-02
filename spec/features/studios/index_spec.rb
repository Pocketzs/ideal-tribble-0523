require 'rails_helper'
# Story 1
# Studio Index

# As a user,
# When I visit the studio index page,
# Then I see all of the studios including name and location,
# And under each studio I see all of the studio's movies
# including the movie's title, creation year, and genre
RSpec.describe 'studio index page' do
  describe 'As a user' do
    describe 'When I visit "/studios"' do

      before :each do
        @studio_1 = Studio.create(name: 'Universal Studios', location: 'Hollywood')
        @studio_2 = Studio.create(name: 'Pixar', location: 'Hollywood')

        @movie_1 = @studio_1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation, family')
        @movie_2 = @studio_1.movies.create(title: 'The Little Mermaid', creation_year: '1991', genre: 'animation, family, fairy_tale')
        @movie_3 = @studio_1.movies.create(title: 'The Lion King', creation_year: '1994', genre: 'animation, action, adventure')
        
        @movie_4 = @studio_2.movies.create(title: 'Shrek', creation_year: '2002', genre: 'animation, adventure, dark, gritty')
        visit '/studios'
      end
      it 'Then I see all of the studios including name and location' do
        expect(page).to have_content(@studio_1.name)
        expect(page).to have_content(@studio_1.location)
        expect(page).to have_content(@studio_2.name)
        expect(page).to have_content(@studio_2.location)
      end

      it "And under each studio I see all of the studio's movies
      including the movie's title, creation year, and genre" do
        within("#studio-#{@studio_1.id}") do
          expect(page).to have_content("#{@movie_1.title}")
          expect(page).to have_content("#{@movie_2.title}")
          expect(page).to have_content("#{@movie_3.title}")
          expect(page).to_not have_content("#{@movie_4.title}")
          expect(page).to have_content("#{@movie_1.creation_year}")
          expect(page).to have_content("#{@movie_2.creation_year}")
          expect(page).to have_content("#{@movie_3.creation_year}")
          expect(page).to_not have_content("#{@movie_4.creation_year}")
          expect(page).to have_content("#{@movie_1.genre}")
          expect(page).to have_content("#{@movie_2.genre}")
          expect(page).to have_content("#{@movie_3.genre}")
          expect(page).to_not have_content("#{@movie_4.genre}")
        end
        within("#studio-#{@studio_2.id}") do
          expect(page).to_not have_content("#{@movie_1.title}")
          expect(page).to_not have_content("#{@movie_2.title}")
          expect(page).to_not have_content("#{@movie_3.title}")
          expect(page).to have_content("#{@movie_4.title}")
          expect(page).to_not have_content("#{@movie_1.creation_year}")
          expect(page).to_not have_content("#{@movie_2.creation_year}")
          expect(page).to_not have_content("#{@movie_3.creation_year}")
          expect(page).to have_content("#{@movie_4.creation_year}")
          expect(page).to_not have_content("#{@movie_1.genre}")
          expect(page).to_not have_content("#{@movie_2.genre}")
          expect(page).to_not have_content("#{@movie_3.genre}")
          expect(page).to have_content("#{@movie_4.genre}")
        end
      end
    end
  end
end