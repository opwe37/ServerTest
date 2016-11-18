require "uri"
require "net/http"
require 'json'

class ClientController < ApplicationController
  
  #로그인 요청
  def login_request
    print("로그인 요청")
    @email = params[:email]
    @password = params[:password]
    
    @client = Client.find_by_email(@email)
    
    if @client != nil
      @password_check = @client.authenticate(@password)
      if @password_check == false
        render plain: "false"
      else
        render json: @client
      end
    else
      render plain: "false"
    end
  end
  
  #회원가입 요청
  def client_join
    new_client = Client.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], nickName: params[:nickName])
    if new_client.save
      render plain: "sucess"
    else
      render plain: "false"
    end
  end
  
  #회원등급 업데이트
  def update_grade
    
    @email = params[:email]
    @membershipGrade = params[:membershipGrade]
    
    @client = Client.find_by_email(@email)
    
    @client.membershipGrade = @membershipGrade
    if @client.save
      render plain: "true"
    else
      render plain: "false"
    end
    
  end
  
  #좋아요 푸드트럭 설정
  def add_like_truck
    
    @client = Client.find_by(id: params[:client_id])
    @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
    @client.foodtrucks << @foodtruck
    
  end
  
  #좋아요 푸드트럭 해제
  def delete_like_truck
    
    @client = Client.find_by(id: params[:client_id])
    @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
    if @client.foodtrucks.delete(@foodtruck)
      render plain: "true"
    else
      render plain: "false"
    end
    
  end
  
  #좋아요_설정된 푸드트럭 리스트 
  def like_truck_list
    
    @client = Client.find_by(id: params[:client_id])
    
    render json: @client.foodtrucks
  end
  
  #검색
  def search_truck
    @keyword = params[:keyword]
    @category = params[:category]
    
    if @category == "all"
      render json: Foodtruck.where('name like ? OR tag like ?', "%#{@keyword}%", "%#{@keyword}%")
    else
      render json: Foodtruck.where(:category => "#{@category}").where('name like ? OR tag like ?', "%#{@keyword}%", "%#{@keyword}%")
    end
    
  end
  
  def foodtruck_list
    render json: Foodtruck.all
  end
  
  #리뷰 리스트 요청
  def foodtruck_review_list
    @foodtruck_id = params[:foodtruck_id]
    
    @foodtruck = Foodtruck.find_by_id(@foodtruck_id)
    
    if @foodtruck != nil
      render json: @foodtruck.reviews
    else
      render plain: false
    end
    
  end
  
  #리뷰 저장 요청 // 중복 저장 문제 있음
  def save_review
    print("리뷰 저장 요청")
    
    @title = params[:title]
    @content = params[:content]
    @rating = params[:rating]
    @client_id = params[:client_id]
    @foodtruck_id = params[:foodtruck_id]
    
    @client = Client.find_by_id(@client_id)
    @foodtruck = Foodtruck.find_by_id(@foodtruck_id)
    
    if @client != nil && @foodtruck != nil
      @review = Review.create(title: @title, content: @content, rating: @rating, client_id: @client_id, foodtruck_id: @foodtruck_id)
    
      if @review.save
        @foodtruck.rating = @foodtruck.reviews.average(:rating)
          if @foodtruck.save
            render json: @foodtruck
          else 
            render plain: "false"
          end
      else 
        render plain: "false"
      end
      
    else 
      render plain: "false"
    end
  end
  
  def list_festivals
    print("행사 리스트 요청")
    
    render json: Festival.all
  end
  
  #행사 공고 요청
  def save_festival
    @title = params[:title]
    @place = params[:place]
    @period = params[:period]
    @s_date = params[:start_date]
    @e_date = params[:end_date]
    @client_id = params[:client_id]
    @support_type = params[:support_type]
    @condition = params[:condition]
    @image = params[:image]
    
    @new_festival = Festival.create(title: @title, place: @place, period: @period, start_date: @s_date, end_date: @e_date, client_id: @client_id, condition: @condition, image: @image)
    
    if @new_festival.save
      render json: @new_festival
    else
      render nil
    end
  end
  
  #위치 검색 요청
  def search_location
    @lat = params[:lat]
    @lng = params[:lng]
    
    render json: Foodtruck.within(0.5, :origin => [@lat, @lng])
  end
  
end
