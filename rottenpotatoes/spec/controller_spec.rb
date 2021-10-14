require 'rails_helper'
require 'spec_helper'
require 'support/support'

describe MoviesController, type: :controller do
  fixtures :movies
  
  describe 'new' do
    it 'do nothing' do
      get :new
      response.response_code.should==200
    end
  end
 
 describe 'go to homepage' do
    it 'shows all movies' do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:movies).count).to eql(Movie.count)
    end
end
  
  describe 'show' do
    it 'show the movie' do
      expect(Movie).to receive(:create!).with({'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}).and_return(movies(:NoTimetoDie))
      post :create, :movie => {'title': 'NoTimetoDie', 'director' => 'CaryJojiFukunaga'}
      get :show, {'id': movies(:NoTimetoDie).id}
      expect(response).to render_template("movies/show")
    end
  end
  
  describe 'create' do
    it ' create a movie' do
      expect(Movie).to receive(:create!).with({'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}).and_return(movies(:NoTimetoDie))
      post :create, :movie => {'title': 'NoTimetoDie', 'director' => 'CaryJojiFukunaga'}
      expect(flash[:notice]).to match(/NoTimetoDie was successfully created/)
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'edit' do
    it 'edit a movie' do
      expect(Movie).to receive(:create!).with({'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}).and_return(movies(:NoTimetoDie))
      post :create, :movie => {'title': 'NoTimetoDie', 'director' => 'CaryJojiFukunaga'}
      get :edit, {'id': movies(:NoTimetoDie).id.to_s}
      expect(response.status).to eq(200)
    end
  end
  
  describe 'update movie' do
    it 'update a movie' do
      expect(Movie).to receive(:find).with(movies(:NoTimetoDie).id.to_s).and_return(movies(:NoTimetoDie))
      post :create, :movie => {'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}
      expect(movies(:NoTimetoDie)).to receive(:update_attributes!).with({'title': 'NoTimetoDie', 'director': 'Ashu'}).and_return(movies(:NoTimetoDie))
      put :update, {'id': movies(:NoTimetoDie).id.to_s, :movie => {'title': 'NoTimetoDie', 'director': 'Ashu'}}
      expect(response).to redirect_to(movie_path)
    end
  end
  
  describe 'delete movie' do
    it 'delete a movie' do
      expect(Movie).to receive(:create!).with({'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}).and_return(movies(:NoTimetoDie))
      post :create, :movie => {'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}
      delete :destroy, {'id': movies(:NoTimetoDie).id.to_s}
      expect(flash[:notice]).to match(/Movie 'NoTimetoDie' deleted/)
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'find movies with the same director' do
    
    it 'specified movie has a director ' do
        expect(Movie).to receive(:create!).with({'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}).and_return(movies(:NoTimetoDie))
        post :create, :movie => {'title': 'NoTimetoDie', 'director': 'CaryJojiFukunaga'}
        expect(Movie).to receive(:find_similar_movies).with(movies(:NoTimetoDie).id.to_s).and_return(movies(:NoTimetoDie))
        get :similar_movie, { 'id': movies(:NoTimetoDie).id.to_s  }
        expect(response.status).to eq(200)
    end
    
    it 'specified movie dose not have a director' do
        expect(Movie).to receive(:create!).with({'title': 'Dune'}).and_return(movies(:Dune))
        post :create, :movie => {'title': 'Dune'}
        expect(Movie).to receive(:find_similar_movies).with(movies(:Dune).id.to_s).and_return(nil)
        get :similar_movie, { 'id': movies(:Dune).id.to_s }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(movies_path)
    end
  end
  
end
