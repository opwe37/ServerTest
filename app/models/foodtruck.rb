class Foodtruck < ActiveRecord::Base
    belongs_to :owner
    has_and_belongs_to_many :clients, -> { uniq }
    has_many :reviews
    has_many :menus
    
    acts_as_mappable :default_units => :kms
    
    mount_uploader :truck_image, TruckImageUploader
    
    def as_json(options = {})
        super.as_json(options).merge({like: cal_like_num})
    end
    
    def cal_like_num
        self.clients.count
    end
    
end