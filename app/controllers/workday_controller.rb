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
        if current_user.nil?
            flash[:error] = "Please login or sign up"
            redirect to "/login"

        elseif params[:shift_start] == "" || params[:shift_start_time] == "" || params[:shift_end] == "" || params[:shift_end_time] == ""
            flash[:error] = "Fill in all fields to submit form"
            redirect to "/workdays/new"

        else 
            @workday = Workday.new(:shift_start => params[:shift_start], :shift_end => params[:shift_end], 
                :shift_start_time => params[:shift_start_time], :shift_end_time => params[:shift_end_time], :notes => params[:notes])
            @workday.user_id = current_user.id
            @workday.save
            redirect to "/workdays/#{@workday.id}"
        end 
        redirect to "/workdays"
    end 

    get '/workdays/:id' do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            erb :'workdays/show'
        else 
            redirect to "/login"
        end 
    end 

    get '/workdays/:id/edit' do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])

            if @workday && (@workday.user_id == current_user.id)
                erb :'workdays/edit'
            else 
                flash[:error] = "You don't have permission to edit this workday"
                redirect to "/workdays"
            end 

        else 
            redirect to "/login"
        end 
    end 

    patch '/workdays/:id' do 
        if logged_in?
            
            if params[:shift_start] == "" || params[:shift_start_time] == "" || params[:shift_end] == "" || params[:shift_end_time] == ""
                flash[:error] = "All fields need information"
                redirect to "/workdays/#{params[:id]}/edit"
                

            else 
            @workday = Workday.find_by_id(params[:id])

                if @workday && (@workday.user_id == current_user.id)

                    @workday.shift_start = params[:shift_start]
                    @workday.shift_start_time = params[:shift_start_time]
                    @workday.shift_end = params[:shift_end]
                    @workday.shift_end_time = params[:shift_end_time]
                    @workday.notes = params[:notes]
                    @workday.save

                    redirect to "/workdays/#{@workday.id}"

                else 
                    flash[:error] = "You don't have permission to update this workday"
                    redirect to "/workdays"

                end 
            end 

        else 
            redirect to "/login"
        end             
    end 

    delete "/workdays/:id/delete" do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            if @workday && (@workday.user_id == current_user.id)
                @workday.delete
                flash[:success] = "You successfully deleted the workday"
                redirect to "/workdays"
            else 
                flash[:error] = "You don't have permission to delete this workday"
                redirect to "/workdays"
            end 
        else 
            redirect to "/login"
        end 
    end 



end 