class CommonController < ApplicationController
    
    def truck_menus
        @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
        
        if @foodtruck != nil
            render json: @foodtruck.menus
        else
            render plain: 'false'
        end
    end
    
end
