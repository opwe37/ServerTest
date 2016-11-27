class OwnerController < ApplicationController
  def owner_join
      @email = params[:email]
      @password = params[:password]
      @phone_number = params[:phone_number]
      @business_number = params[:business_number]
      
      @owner_check = Owner.find_by(email: @email)
      
      if @owner_check == nil
          @owner = Owner.new(email: @email, password: @password, password_confirmation: @password, phone_number: @phone_number, business_number: @business_number)
          if @owner.save
              render plain: 1
          else
              render plain: 2
          end
      else
          render plain: 3 
      end
  end
  
  def truck_info_save
      @name = params[:name]
      @category = params[:category]
      @tag = params[:tag]
      @payment_card = params[:payment_card]
      @region = params[:region]
      @truck_image = params[:truck_image]
      @owner_id = params[:owner_id]
      
      @foodtruck = Foodtruck.new(name: @name, category: @category, tag: @tag, payment_card: @payment_card, region: @region, truck_image: @truck_image, owner_id: @owner_id)
      if @foodtruck.save
        render json: @foodtruck
      else
        render json: nil
      end
  end
  
  def login_request
      @email = params[:email]
      @password = params[:password]
    
      @owner = Owner.find_by(email: @email)
    
      if @owner != nil
          @password_check =  @owner.authenticate(@password)
          if @password_check == false
              render json: nil
          else
              render json: @owner.to_json(:except => [:password_digest])
          end
      end
  end
  
  def changeOwnerInfo
      @request_info = params[:request_info]
      @data = JSON.parse @request_info
      
      @owner = Client.find_by(id: @data["owner_id"])
      if @owner != nil
          @update_check = Client.update(params[:owner_id], :email => @data["email"],
                                                           :phone_number => @data["phone_number"],
                                                           :business_number => @data["business_number"])
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
      @owner = Owner.find_by(id: params[:owner_id])
      
      if @owner != nil
          @password = params[:password]
          @update_check = Owner.update(params[:owner_id], :password => @password, :password_confirmation => @password)
          if @update_check == false
              render plain 2 #비밀번호 변경 실패
          else
              render plain 1 #비밀번호 변경 성공
          end
      else
          render plain: 3 #잘못된 소비자 아이디
      end
  end
  
  # 내 푸드트럭 정보 요청
  def mytruck_info
      @owner = Owner.find_by(id: params[:owner_id])
      
      if @owner != nil
          render :json => @owner.foodtruck.as_json()
      else
          render json: nil
      end
  end
  
  #======================= 행사 관련 =======================
    #행사 신청
  def request_festival
      @owner = Owner.find_by_id(params[:owner_id])
      @festival = Festival.find_by_id(params[:festival_id])
    
      if @owner != nil && @festival != nil
          @festival.owners<<@owner
          if @festival.save
              render :json => @festival.as_json()
          else
              render json: nil
          end
      else
          render json: nil
      end
  end
  
    #행사 신청 취소
  def request_cancle_festival
      @owner = Owner.find_by_id(params[:owner_id])
      @festival = Festival.find_by_id(params[:festival_id])
    
      if @owner != nil && @festival != nil
          @owner.festivals.delete(@festival)
          if @owner.save
              render plain: "true"
          else
              render plain: "false"
          end
      else
          render plain: "false"
      end
  end
  
  def selected_festival_info
    @foodtruck = Foodtruck.find_byparams[:foodtruck_id]
  end
  
  #======================= 영업 관련 =======================
  #영업 시작 및 위치 설정
  def set_open
      @foodtruck = Foodtruck.find_by_id(params[:foodtruck_id])
    
      if @foodtruck != nil
          @foodtruck.open = true
          @foodtruck.lat = params[:lat]
          @foodtruck.lng = params[:lng]
          if @foodtruck.save
              sendToClientMessage(params[:foodtruck_id])
              render plain: "true"
          else
              render plain: "false"
          end
      else
          render plain: "false"
      end
  end
  
  #영업 종료 설정
  def set_close
      @foodtruck = Foodtruck.find_by(id: params[:foodtruck_id])
    
      if @foodtruck != nil
          @foodtruck.open = false
          @foodtruck.lat = nil
          @foodtruck.lng = nil
          if @foodtruck.save
              render plain: true
          else
              render plain: false
          end
      else
          render plain: false
      end
  end
  
  #======================= 메뉴 관련 =======================
  #메뉴 추가
  def add_menu
      @menu_info = params[:menu_info]
      @data = JSON.parse @menu_info
    
      @foodtruck = Foodtruck.find_by(id: @data["foodtruck_id"])
      
      @menu_list = @foodtruck.menus
      @menu_list.each { |menu| 
          if menu.name == @data["name"]
              render plain: false
              return
          else
              next
          end
      }
      
      if @foodtruck != nil
          @menu = Menu.new(name: @data["name"],
                           price: @data["price"],
                           foodtruck_id: @data["foodtruck_id"],
                           image: params[:menu_image])
          if @menu.save == true
              render plain: true
          else
              render plain: false
          end
      else
          render plain: false
      end
  end
  
  #메뉴 삭제
  def delete_menu
      @menu = Menu.find_by(id: params[:menu_id])
    
      if @menu != nil
          @menu.destroy
          render plain: true
      else
          render plain: false
      end
  end

  #======================== FCM 관련 =======================
  def sendfcm(user_token)
      fcm = FCM.new("AAAAVEyGzaM:APA91bEDoSERenu9Hi81R0tG5St-F-fz8zKUjd_TzRMdGEmtSVpizwFxWfifClAe4HA1A8Maxr79whYPlHV-LUS9DosU50KV8HI5Jtbi7uUMzEB_v42D9g4bZ2GHqc2N2DrppblLakbnT0Sqa2WrjUsKWLN-MDAFfQ")
        
      registration_ids = user_token
      options = {data: {msg: "푸드트럭이 도착!! 어서빨리 먹으러 가세요!"}}
      response = fcm.send(registration_ids, options)
        
      puts response
  end
  
  def sendToClientMessage(foodtruck_id)
      @foodtruck = Foodtruck.find_by(id: foodtruck_id)
      if @foodtruck != nil
          @client_list = @foodtruck.clients
          @fcm_list = @client_list.within(0.5, :origin => [@foodtruck.lat, @foodtruck.lng])
          @token_list = Array.new()
          
          @fcm_list.each { |client|
              @token_list.push(client.token)
          }
          
          sendfcm(@token_list)
      end
  end
  
end
