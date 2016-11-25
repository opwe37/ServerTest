require "uri"
require "net/http"
require 'json'

class ClientController < ApplicationController
  
  #======================= 회원 정보 관리 =======================
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
  
  #로그인 요청
  def login_request
      print("로그인 요청")
      @email = params[:email]
      @password = params[:password]
    
      @client = Client.find_by_email(@email)
    
      if @client != nil
          @password_check = @client.authenticate(@password)
          if @password_check == false
              render json: nil
          else
              render json: @client.to_json(:except => [:password_digest])
          end
      else
          render json: nil
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
  
  #회원 정보 업데이트
  def change_info
      @request_info = params[:request_info]
      @data = JSON.parse @request_info
      
      @client = Client.find_by(id: @data["client_id"])
      if @client != nil
          @update_check = Client.update(params[:client_id], :email => @data["email"], :nickName => @data["nickName"],
                                                            :phone_number => @data["phone_number"],
                                                            :lat => @data["lat"], :lng => @data["lng"])
          if @update_check == false
              render plain: 2 #정보 업데이트 실패
          else
              render plain: 1 #정보 업데이트 성공
          end
      else
          render plain: 3 #잘못된 소비자 아이디
      end
  end
  
  #비밀번호 변경 요청
  def change_password
      @client = Client.find_by(id: params[:client_id])
      
      if @client != nil
          @password = params[:password]
          @update_check = Client.update(params[:client_id], :password => @password, :password_confirmation => @password)
          if @update_check == false
              render plain 2 #비밀번호 변경 실패
          else
              render plain 1 #비밀번호 변경 성공
          end
      else
          render plain: 3 #잘못된 소비자 아이디
      end
  end
  
  #회원등급 업데이트
  def update_grade
      @client = Client.find_by(id: params[:client_id])
      
      if @client != nil
          @membershipGrade = params[:membershipGrade]
          @client.membershipGrade = @membershipGrade
          if @client.save
              render plain: 1 #회원등급 업데이트 성공
          else
              render plain: 2 #회원등급 업데이트 실패
          end
      else
          render plain: 3 #잘못된 소비자 아이디
      end
  end
  
  #소비자 위치 설정 => 소비자 개인정보 변경시 변경을 한다면 지워도 됨
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
  
  #======================= 푸드트럭 정보 검색 =======================
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
  
  #푸드트럭 리스트 요청
  def foodtruck_list
      @category = params[:category]
    
      if @category == '0'
          render json: Foodtruck.all
      else
          render json: Foodtruck.where(:category => "#{@category}")
      end
  end
  
  #위치 검색 요청
  def search_location
      @lat = params[:lat]
      @lng = params[:lng]
    
      render json: Foodtruck.within(0.5, :origin => [@lat, @lng])
  end
  
  #======================= 좋아요 푸드트럭 관리 =======================
  #좋아요 푸드트럭 설정
  def add_like_truck
      @client = Client.find_by(id: params[:client_id])
      @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
      if @client != nil && @foodtruck != nil
          @client.foodtrucks << @foodtruck
          render plain: true
      else
          render plain: false
      end
  end
  
  #좋아요 푸드트럭 해제
  def delete_like_truck
      @client = Client.find_by(id: params[:client_id])
      @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
      
      @delete_check = @client.foodtrucks.delete(@foodtruck)
      if @delete_check == false
          render plain: false
      else
          render plain: true
      end
  end
  
  #좋아요_설정된 푸드트럭 리스트 
  def like_truck_list
      @client = Client.find_by(id: params[:client_id])
    
      if @client != nil
          render :json => @client.foodtrucks.as_json()
      else
          render json: nil
      end
  end
  
  #======================= 리뷰 =======================
  #리뷰 중복 검사 실시
  #리뷰 업데이트(한번더 썼을 때)
  
  #리뷰 저장 요청(처음 글쓸 때)
  def save_review
      print("리뷰 저장 요청")
      
      @review_info = params[:review_info]
      @data = JSON.parse @review_info
    
      @client = Client.find_by_id(@data["client_id"])
      @foodtruck = Foodtruck.find_by_id(@data["foodtruck_id"])
    
      if @client != nil && @foodtruck != nil
          @review = Review.new(title: @data["title"], content: @data["content"],
                               rating: @data["rating"], client_id: @data["client_id"], 
                               foodtruck_id: @data["foodtruck_id"], image: params[:image])
          if @review.save
              @foodtruck.rating = @foodtruck.reviews.average(:rating)
              if @foodtruck.save
                  render json: @foodtruck
              else 
                  render json: nil
              end
          else 
              render json: nil
          end
      else 
          render json: nil
      end
  end
  
  #======================= 행사 =======================
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
  
  #======================= FCM =======================
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
  
end