class WorkdayController < ApplicationController

    get "/workdays" do 
        if logged_in?
            @workdays = Workday.all
            erb :'workdays/index'
        else 
            redirect to "/login"
        end 
    end 

    get "/workdays/new" do 
        if logged_in?
            erb :'workdays/new'
        else 
            redirect to "/login"
        end 
    end 

    post "/workdays" do 
        @workday = Workday.new(:shift_start => params[:shift_start], :shift_end => params[:shift_end], :notes => params[:notes])
        redirect to "/workdays/#{@workday.id}"
    end 

    get "/workdays/:id" do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            erb :'workdays/show'
        else 
            redirect to "/login"
        end 
    end 

    get "/workdays/:id/edit" do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            erb :'workdays/edit'
        else 
            redirect to "/login"
        end 
    end 

    patch "/workdays/:id" do 
        @workday = Workday.find_by_id(params[:id])
        @workday.shift_start = params[:shift_start]
        @workday.shift_end = params[:shift_end]
        @workday.notes = params[:notes]
        @workday.save
        redirect to "/workdays/#{@workday.id}"
    end 

    delete "/workdays/:id/delete" do 
        @workday = Workday.find_by_id(params[:id])
        @workday.delete
        redirect to "/workdays"
    end 



end 