class MoviesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        start = Integer(params[:start] || '0')
        count = Integer(params[:count] || '10')

        movies = Movie.offset(start).take(count)
        render :locals => { movies: movies, next_start: start + count }
    end
    
    def show
        movie = Movie.find(params[:id])
        render :locals => { movie: movie }
    end

    def new
        movie = Movie.new
        render :locals => { movie: movie }
    end

    def create
        title = params[:movie][:title]
        director = params[:movie][:director]
        year = params[:movie][:year]

        movie = Movie.create(title: title, director: director, year: year)

        redirect_to "/movies/#{movie.id}", locals: { movie: movie }
    end

    def edit
        movie = Movie.find(params[:id])
        render :locals => { movie: movie }
    end

    def update
        id = params[:id]

        movie = Movie.find(id)
        movie.update(movie_params)

        redirect_to "/movies/#{movie.id}", locals: { movie: movie }
    end

    private

    def movie_params
        params.require(:movie).permit(:title, :director, :year)
    end
end
