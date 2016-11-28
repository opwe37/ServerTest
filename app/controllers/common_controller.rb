class CommonController < ApplicationController
    
    #메뉴 요청
    def truck_menus
        @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
        
        @test = Client.first
        
        if @foodtruck != nil
            render json: @foodtruck.menus
        else
            render json: nil
        end
    end
    
    #전체 리뷰 요청
    def foodtruck_reviews
        @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
        if @foodtruck != nil
            render json: @foodtruck.reviews.order('updated_at desc')
        else
            render json: nil
        end
    end
    
    #행사 정보 전송
    def festival_info
        @festival_list = Festival.where('end_date > ?', DateTime.now)
        
        if @festival_list != nil
            render json: @festival_list
        else
            render json: nil
        end
    end
    
    def request_ReviewComments
        @review = Review.find_by(id: params[:review_id])
        @count = @review.comments.count
        
        if @count == 0
            render json: nil
        else
            render json: @review.comments
        end
    end
end
