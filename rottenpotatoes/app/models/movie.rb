class Movie < ActiveRecord::Base
    def self.find_similar_movies(movie)
         director = Movie.find_by_id(movie).director
         if director.nil? or director.blank?
             return nil
        end
         Movie.where(director: director)
     end
end
