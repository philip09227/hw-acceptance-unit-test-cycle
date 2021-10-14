require 'rails_helper'
require 'spec_helper'
require 'support/support'

describe Movie do
    
    it "able to get ratings" do
        Movie.should respond_to(:all_ratings)
    end
    
    it " rating" do 
        expect(Movie.all_ratings()[0].to_s).to include("G")
    end
    
    it " get one rating" do 
        expect(Movie.get_movie_rating_collection()[0].to_s).to include("PG-13")
    end
    
    it "responds to have_ratings" do
        Movie.should respond_to(:have_ratings)
    end
    
    describe "movies with id" do
        it "rating should fit title " do
            Movie.create('title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga', 'rating': 'PG-13')
            Movie.create('title': 'movie_title1', 'director': 'movie_director2', 'rating': 'PG')
            Movie.create('title': 'movie_title2', 'director': 'movie_director3', 'rating': 'R')
            Movie.create('title': 'movie_title3', 'director': 'movie_director4', 'rating': 'G')
            expect(Movie.have_ratings(['PG-13'],nil).pluck('title')).to include('NoTimetoDie')
            expect(Movie.have_ratings(['PG'],nil).pluck('title')).to include('movie_title1')
            expect(Movie.have_ratings(['R'], nil).pluck('title')).to include('movie_title2')
            expect(Movie.have_ratings(['G'], nil).pluck('title')).to include('movie_title3')
            expect(Movie.have_ratings(['G'],nil).pluck('title')).not_to include('NoTimetoDie')
            expect(Movie.have_ratings(['R'],nil).pluck('title')).not_to include('NoTimetoDie')
            expect(Movie.have_ratings(['PG'],nil).pluck('title')).not_to include('NoTimetoDie')
           
        end
    end
    

    it "responds to similar_to" do
        Movie.should respond_to(:find_similar_movies)
    end
    
    describe "find movie with same director." do
        it "it should return the correct matches for movies by the same director " do
            Movie.create('title': 'movie_title1', 'director': 'movie_director1')
            movie_id =  Movie.where('director': 'movie_director1').pluck('id')[0]
            Movie.create('title': 'movie_title2', 'director': 'movie_director1') 
            Movie.create('title': 'movie_title3', 'director': 'movie_director2')
            expect( Movie.find_similar_movies(movie_id.to_s).pluck(:title) ).to include('movie_title1')
            expect( Movie.find_similar_movies(movie_id.to_s).pluck(:title) ).to include('movie_title2')
            expect( Movie.find_similar_movies(movie_id.to_s).pluck(:title) ).not_to include('movie_title3')
        end
    end
  
    describe "movie without director " do
        it "movie with no director should return nil" do
            Movie.create('title': 'movie1', 'director': "")
            movie_id =  (Movie.where('director': 'director').pluck('id')[0]).to_s
            expect(movie_id).to eq("")
        end
    end
end
