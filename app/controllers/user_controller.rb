class UserController < ApplicationController

    get "/login" do 
        if !logged_in?
            flash[:login] = "Please enter your username and password"
            erb :'user/login'
        else
            redirect to "/workdays"
        end 
    end 

    post "/login" do 
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/workdays"
        else 
            flash[:error] = "Invalid username/ password. Please enter correct information or visit sign-up page"
            redirect to "/login"
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
            flash[:error] = "Both fields are required to sign up"
            redirect to "/signup"
        else 
            if @user && @user.authenticate(params[:username])
                @user = User.new(:username => params[:username], :password => params[:password])
                @user.save
                session[:user_id] = @user.id
                redirect to "/workdays" 
            else
                flash[:error] = "Username has already been taken, please choose another one"
                redirect to "/signup"
            end    
        end 
    end 

    get "/logout" do 
        if logged_in?
            session.destroy
            flash[:logout] = "You have successfully logged out"
            redirect to "/login"
        else 
            redirect to "/"
        end 
    end 
    
end 