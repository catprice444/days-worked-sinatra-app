class UserController < ApplicationController

    get "/login" do 
        erb :'user/login'
    end 

    get "/signup" do 
        erb :'user/signup'
    end 
    
end 