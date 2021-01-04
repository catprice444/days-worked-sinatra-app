class UserController < ApplicationController

    get "/login" do 
        if !logged_in?
            erb :'user/login'
        else 
            redirect to "/workdays"
        end 
    end 

    post "/login" do 
        @user = User.find_by(:username ==> params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/workdays"
        else 
            redirect to "/signup"
        end 
    end 

    get "/signup" do 
        if !logged_in?
            erb :'user/signup'
        else 
            redirect to "/workdays"
        end 
    end 

    post "/signup" do 
        if params[:username] == "" || params[:password] == ""
            redirect to "/signup"
        else 
            @user = User.new(:username ==> params[:username], :password ==> params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to "/workdays"
        end 
    end 

    get "/logout" do 
        if logged_in?
            session.destroy
            redirect to "/login"
        else 
            redirect to "/"
        end 
    end 
    
end 