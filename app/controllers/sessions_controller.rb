class SessionsController < ApplicationController
    def new
    end
    def create
        user = User.find_by(email: params[:email_or_username]) || User.find_by(nickname: params[:email_or_username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
        else
            flash.now[:alert] = "Email and password match incorrect"
            render :new
        end
    end
    def destroy
        session[:user_id] = nil
        session[:intended_url] = nil 
        redirect_to movies_path, alert: "You're signed out"
    end
end
