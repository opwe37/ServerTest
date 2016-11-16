class OwnerController < ApplicationController
  def owner_join
      @email = params[:email]
      @password = params[:password]
      @phone_number = params[:phone_number]
      @business_number = params[:business_number]
      
      @owner = Owner.create(email: @email, password: @password, password_confirmation: @password, phone_number: @phone_number, business_number: @business_number)
      if @owner.save
        render json: @owner
      else
        render plain: "false"
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
      
      @foodtruck = Foodtruck.create(name: @name, category: @category, tag: @tag, payment_card: @payment_card, region: @region, truck_image: @truck_image, owner_id: @owner_id)
      if @foodtruck.save
        render json: @foodtruck
      else
        render plain: "false"
      end
  end
  
    #행사 신청
  def request_festival
    @owner = Owner.find_by_id(params[:owner_id])
    @festival = Festival.find_by_id(params[:festival_id])
    
    if @owner != nil && @festival != nil
        @owner.festivals<<@festival
        if @owner.save
          render plain: "true"
        else
          render plain: "false"
        end
    else
      render plain: "false"
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
  
end
