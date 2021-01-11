class WorkdayController < ApplicationController

    get '/workdays' do 
        if logged_in?
            @workdays = Workday.all
            erb :'/workdays/index'
        else 
            redirect '/login'
        end 
    end 

    get '/workdays/new' do 
        if logged_in?
            erb :'/workdays/new'
        else 
            redirect '/login'
        end 
    end 

    post '/workdays' do 
        if current_user.nil?
            flash[:error] = "Please login or sign up"
            redirect '/login'

        elsif params[:shift_start] == "" || params[:shift_start_time] == "" || 
                params[:shift_end] == "" || params[:shift_end_time] == "" || params[:notes] == ""
            flash[:error] = "Fill in all fields to submit form"
            redirect '/workdays/new'

        elsif (params[:shift_start] > params[:shift_end])
            flash[:error] = "Check dates"
            redirect '/workdays/new'

        else 
            @workday = Workday.new(:shift_start => params[:shift_start], :shift_end => params[:shift_end], 
                :shift_start_time => params[:shift_start_time], :shift_end_time => params[:shift_end_time], 
                :notes => params[:notes])
            @workday.user_id = current_user.id
            @workday.save
            redirect "/workdays/#{@workday.id}"
        end 
        redirect '/workdays'
    end 

    get '/workdays/:id' do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            erb :'/workdays/show'
        else 
            redirect '/login'
        end 
    end 

    get '/workdays/:id/edit' do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])

            if @workday && (@workday.user_id == current_user.id)
                erb :'/workdays/edit'
            else 
                flash[:error] = "You don't have permission to edit this workday"
                redirect '/workdays'
            end 

        else 
            redirect '/login'
        end 
    end 

    patch '/workdays/:id' do 
        if logged_in?
            if params[:shift_start] == "" || params[:shift_start_time] == "" || 
                params[:shift_end] == "" || params[:shift_end_time] == "" || params[:notes] == ""
                flash[:error] = "All fields need information"
                redirect "/workdays/#{params[:id]}/edit"
            
            elsif (params[:shift_start] > params[:shift_end])
                flash[:error] = "Check dates"
                redirect "/workdays/#{params[:id]}/edit"
            else 
            @workday = Workday.find_by_id(params[:id])

                if @workday && (@workday.user_id == current_user.id)
                    @workday.update(:shift_start => params[:shift_start], :shift_end => params[:shift_end], 
                        :shift_start_time => params[:shift_start_time], :shift_end_time => params[:shift_end_time], 
                        :notes => params[:notes])
                    redirect "/workdays/#{@workday.id}"
                else 
                    flash[:error] = "You don't have permission to update this workday"
                    redirect '/workdays'
                end 
            end 

        else 
            redirect '/login'
        end             
    end 

    
 

    delete '/workdays/:id' do 
        if logged_in?
            @workday = Workday.find_by_id(params[:id])
            if @workday && (@workday.user_id == current_user.id)
                @workday.delete
                flash[:success] = "You successfully deleted the workday"
                redirect "/workdays"
            else 
                flash[:error] = "You don't have permission to delete this workday"
                redirect "/workdays"
            end 
        else 
            redirect "/login"
        end 
    end 



end 