class WorkdayController < ApplicationController

    get "/workdays" do 
        # if logged_in? 

        erb :'workdays/index'
    end 
end 