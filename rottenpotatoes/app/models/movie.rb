class Movie < ActiveRecord::Base
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
    def self.have_ratings(ratinglist, sort)
        ratinglist.map!(&:upcase)
        ratinglist.nil? ? self.all.order(sort) : self.where('rating': ratinglist).order(sort)
    end
    
    def self.find_similar_movies(movie)
         director = Movie.find_by_id(movie).director
         if director.nil? or director.blank?
             return nil
        end
         Movie.where(director: director)
     end
    
    def self.get_movie_rating_collection
        self.distinct.pluck(:rating)
    end
    

end
