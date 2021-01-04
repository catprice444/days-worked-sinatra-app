class WorkdayController < ApplicationController

    get "/workdays" do 
        erb :'workdays/index'
    end 
end 