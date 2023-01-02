require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it { should have_many :movie_actors }
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe 'instance methods' do
    before :each do
      @studio_1 = Studio.create(name: 'Universal Studios', location: 'Hollywood')
      @movie_1 = @studio_1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation, family')
      @actor_1 = Actor.create(name: 'Meryl Streep', age: 73)
      @actor_2 = Actor.create(name: 'Cidny Walker', age: 23)
      @actor_3 = Actor.create(name: 'Keanu Reeves', age: 302)
      @movie_1.actors << @actor_1
      @movie_1.actors << @actor_2
      @movie_1.actors << @actor_3
    end
    describe '#actors_by_youngest' do
      it 'returns an array of a movies actors ordered from youngest to oldest' do
        expected = [@actor_2, @actor_1, @actor_3]

        expect(@movie_1.actors_by_youngest).to eq(expected)
      end
    end

    describe '#average_actor_age' do
      it 'returns the average age of a movies actors' do
        expect(@movie_1.average_actor_age.round(3)).to eq(132.667)
      end
    end
  end
end
