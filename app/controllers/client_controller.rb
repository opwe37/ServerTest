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
      @client_info = params[:client_info]
      @data = JSON.parse @client_info
      
      @client_check = Clietn.find_by(email: @data["email"])
    
      if @client_check == nil
          @new_client = Client.new(email: @data["email"], 
                                   password: @data["password"], password_confirmation: @data["password"], 
                                   nickName: @data["nickName"])
          if @new_client.save
              render plain: 1
          else
              render plain: 2
          end
      else
          render plain: 3
      end
  end
  
  #소비자 이미지 저장
  def upload_image
      @client = Client.find_by(id: params[:client_id])
      @image = params[:image]
    
      if @client != nil
          @client.image = @image
          render plain: true
      else
          render plain: false
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
    
    render :json => @client.foodtrucks.as_json()
  end
  
  #검색
  def search_truck
    @keyword = params[:keyword]
    @category = params[:category]
    
    if @category == '0'
      render json: Foodtruck.where('name like ? OR tag like ?', "%#{@keyword}%", "%#{@keyword}%")
    else
      render json: Foodtruck.where(:category => "#{@category}").where('name like ? OR tag like ?', "%#{@keyword}%", "%#{@keyword}%")
    end
    
  end
  
  def foodtruck_list
    @category = params[:category]
    
    if @category == '0'
      render json: Foodtruck.all
    else
      render json: Foodtruck.where(:category => "#{@category}")
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
      @image = params[:festival_image]
      @festival_info = params[:festival_info]
      @data = JSON.parse @festival_info
      
      if @data["applicant_end"] < DateTime.now || @data["end_date"] < DateTime.now
          render plain: 3
          return
      else
          @festvial = Festival.new(title: @data["title"], place: @data["place"],
                                   applicant_start: @data["applicant_start"], applicant_end: @data["applicant_end"],
                                   start_date: @data["start_date"], end_date: @data["end_date"],
                                   client_id: @data["client_id"], support_type: @data["support_type"],
                                   condition: @data["condition"], limit_num_of_application: @data["limit_num_of_application"])
      
          if @data["start_date"] > DateTime.now
              @festival.status = 0
          else
              @festival.status = 1
          end
      
          if @festvial.save
              render plain: 1
          else
              render plain: 2
          end
      end
  end
  
  #위치 검색 요청
  def search_location
      @lat = params[:lat]
      @lng = params[:lng]
    
      render json: Foodtruck.within(0.5, :origin => [@lat, @lng])
  end
  
  #fcm서비스를 위한 토큰 저장
  def save_token
      @token = params[:token]
      @client = Client.find_by(id: params[:client_id])
        
      if @client != nil
          @client.token = @token
          if @client.save
              render plain: true
          else
              render plain: false
          end
      else
          render plain: false
      end
  end
  
  #소비자 위치 설정
  def set_location
      @lat = params[:lat]
      @lng = params[:lng]
      
      @client = Client.find_by(id: params[:client_id])
      
      if @client != nil
          @client.lat = @lat
          @client.lng = @lng
          if @client.save
              render plain: true
          else
              render plain: false
          end
      else
          render plain: false
      end
  end
  
end