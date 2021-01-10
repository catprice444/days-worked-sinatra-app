patch '/workdays/:id' do 
        if logged_in?
            if params[:shift_start] == "" || params[:shift_start_time] == "" || 
                params[:shift_end] == "" || params[:shift_end_time] == "" || params[:notes] == ""
                flash[:error] = "All fields need information"
                redirect "/workdays/#{params[:id]}/edit"
            else 
            @workday = Workday.find_by_id(params[:id])
                if @workday && (@workday.user_id == current_user.id)
                    @workday.update(shift_start: params[:shift_start], shift_start_time: params[:shift_start_time],
                        shift_end: params[:shift_end], shift_end_time: params[:shift_end_time], 
                        notes: params[:notes])
                    redirect "/workdays/#{@workday.id}"
                else 
                    flash[:error] = "You don't have permission to update this workday"
                    redirect "/workdays"
                end 
            end 
        else 
            redirect "/login"
        end             
    end  
