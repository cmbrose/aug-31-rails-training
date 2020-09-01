class MoviesController < ApplicationController
    def show
        id = params[:id]
        
        if id == "1"
            title = 'Parasite'
            director = 'Bong Joon-ho'

            # @movie = { title: 'Parasite', director: 'Bong Joon-ho' }
        elsif id == "2"
            title = 'Titanic'
            director = 'James Cameron'

            # @movie = { title: 'Titanic', director: 'James Cameron' }
        end

        render :locals => { title: title, director: director }
    end
end
