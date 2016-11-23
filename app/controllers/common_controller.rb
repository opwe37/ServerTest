class CommonController < ApplicationController
    
    #메뉴 요청
    def truck_menus
        @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
        
        @test = Client.first
        sendfcm(@test.token)
        
        if @foodtruck != nil
            render json: @foodtruck.menus
        else
            render plain: 'false'
        end
    end
    
    #전체 리뷰 요청
    def foodtruck_reviews
        @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
        if @foodtruck != nil
            render json: @foodtruck.reviews
        else
            render plain: false
        end
    end
    
end
