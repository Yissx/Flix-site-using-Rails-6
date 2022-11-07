class MoviesController < ApplicationController

    before_action :require_signin, except: [:show, :index]
    before_action :require_admin, except: [:show, :index]
    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
        @movies = Movie.send(movies_filter)
    end
    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end
    def edit
        # @movie = Movie.find(params[:id])
    end
    def update
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie succesfully updated"
        else
            render :edit
        end
    end
    def new
        @movie = Movie.new
    end
    def create
        @movie = Movie.create(movie_params)
        if @movie.save
            redirect_to @movie, notice: "Movie succesfully created" # same as redirect_to movie_path(@movie)
        else
            render :new
        end
    end
    def destroy
        @movie.destroy
        redirect_to movies_url, alert: "Movie succesfully deleted"
        # redirect_to movies_url, danger: "I'm sorry, Dave, I'm afraid I can't do that!"
    end
    private
    def movie_params
        params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
    end
    def movies_filter
        if params[:filter].in? %w(upcoming hits released)
            params[:filter]
        else
            :released
        end
    end
    def set_movie
        @movie = Movie.find_by!(slug: params[:id])
    end
end
