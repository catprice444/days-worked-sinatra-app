class UserController < ApplicationController

    get "/login" do 
        if !logged_in?
            erb :'user/login'
        else 
            redirect to "/workdays"
        end 
    end 

    post "/login" do 
        erb :'workdays/index'
    end 

    get "/signup" do 
        if !logged_in?
            erb :'user/signup'
        else 
            redirect to "/workdays"
        end 
    end 

    post "/signup" do 
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