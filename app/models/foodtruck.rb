class Foodtruck < ActiveRecord::Base
    belongs_to :owner
    has_and_belongs_to_many :clients, -> { uniq }
    has_many :reviews
    has_many :menus
    
    acts_as_mappable :default_units => :kms
    
    mount_uploader :image, TruckImageUploader
    
    def as_json(options = {})
        super.as_json(options).merge({like: cal_like_num})
                              .merge({review_num: cal_reivew_num})
                              .merge({phone_number: owner_phone})
    end
    
    def cal_like_num
        self.clients.count
    end
    
    def cal_reivew_num
        self.reviews.count
    end
    
    def owner_phone
        @number = self.owner[:phone_number]
        return @number
    end
    
    def self.close_truck
        @truck_list = Foodtruck.where(:open => true)
        @truck_list.each { |truck|
            truck.open = false
            truck.save
        }
    end
end