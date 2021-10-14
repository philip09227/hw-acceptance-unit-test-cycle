require 'spec_helper'
require 'rails_helper.rb'
describe MoviesController , :type => :controller do
    describe "#show" do
        it "Should show movie attributes" do
            @movie_id = "234"
            @movie = double("movie",:title => "random")
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :show, {:id => @movie_id}
            expect(response).to render_template(:show)
        end
    end
end
