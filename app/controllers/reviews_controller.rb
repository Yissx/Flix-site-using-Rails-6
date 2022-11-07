class ReviewsController < ApplicationController
    
    before_action :set_movie
    before_action :set_review, except: [:index, :create, :new]
    before_action :require_signin #, only: [:new, :create]
    before_action :require_author_user, only: [:edit, :destroy, :update]

    def index
        @reviews = @movie.reviews
    end
    def new
        @review = @movie.reviews.new
    end
    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
        else
            render :new
        end
    end
    
    def edit
        #@review = @movie.reviews.find(params[:id])
    end
    def update
        if @review.update(review_params)
            redirect_to movie_reviews_path(@movie), notice: "Review correctly updated"
        else
            render :edit
        end
    end
    def destroy
        @review.destroy
        redirect_to movie_reviews_path(@movie), alert: "Movie succesfully deleted"
    end
    private
    def set_review
        @review = @movie.reviews.find(params[:id])
    end
    def review_params
        params.require(:review).permit(:stars, :comment)
    end
    def set_movie
        @movie = Movie.find_by!(slug: params[:movie_id])
    end
    def require_author_user
        unless author_user?(@review.user)
            redirect_to movie_reviews_path(@movie), alert: "Unauthorized user"
        end
    end
    def author_user?(user)
        current_user == user
    end

    helper_method :author_user?
end
