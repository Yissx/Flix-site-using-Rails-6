class GenresController < ApplicationController
    
    before_action :require_admin
    before_action :set_genre, except: [:index, :new, :create]

    def index
        @genres = Genre.order(:name)
    end
    def new
        @genre = Genre.new
    end
    def create
        @genre = Genre.create(genre_params)
        if @genre.save 
            redirect_to @genre, notice: "Genre succesfully created!"
        else
            render :new
        end
    end
    def destroy
        @genre.destroy
        redirect_to genres_path, alert: "Genre succesfully deleted"
    end
    def edit
        @movies = Movie.all
    end
    def update
        if @genre.update(genre_params)
            redirect_to @genre, notice: "#{@genre.name} genre succesfully updated!"
        else
            render :new
        end
    end
    def show
        @movies = genres(@genre)
    end
    
    private
    def get_image_from_movie_for_genre(genre)
        selected_movie = genre.movie_ids.sample
        movie = Movie.find(selected_movie)
        movie.image_file_name
    end
    def genres(genre)
        movies = Movie.order(:title)
        genre_movies = Array.new
        movies.each do |movie|
            if movie.genres.include?(genre)
                genre_movies << movie 
            end
        end
        genre_movies
    end
    def genre_params
        params.require(:genre).permit(:name, movie_ids: [])
    end
    def set_genre
        @genre = Genre.find_by!(slug: params[:id])
    end

    helper_method :get_image_from_movie_for_genre
end
