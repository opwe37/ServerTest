require "uri"
require "net/http"
require 'json'

class ClientController < ApplicationController
  
  #로그인 요청
  def login_request
    print("로그인 요청");
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
  
end
