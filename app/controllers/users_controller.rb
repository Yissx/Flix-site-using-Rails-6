class UsersController < ApplicationController
    
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:destroy, :edit, :update]
    helper_method :current_user?
    
    def index
        @users = User.all
    end
    def show
        @user = User.find_by!(slug: params[:id])
        @reviews = @user.reviews
        @favorite_movies = @user.favorite_movies
    end
    def new
        @user = User.new
    end
    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Account correctly created"
        else
            render :new
        end
    end
    def edit
        # @user = User.find(params[:id]) Esta línea ya se corre en require_correct_user (función ejecutada antes de edit, destroy, update)
    end
    def update
        if @user.update(user_params)
            redirect_to users_path, notice: "Account succesfully updated"
        else
            render :edit
        end
    end
    def destroy
        @user.destroy
        session[:user_id] = nil
        redirect_to users_path, alert: "Account succesfully deleted"
    end
    private 
    def user_params
        params.require(:user).permit(:name, :nickname, :email, :password, :password_confimation)
    end
    def require_correct_user
        @user = User.find_by!(slug: params[:id])
        unless current_user?(@user) || current_user_admin?
            redirect_to root_url 
        end
    end
    def current_user?(user)
        current_user == user
    end
end
