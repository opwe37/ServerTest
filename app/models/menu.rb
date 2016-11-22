class Menu < ActiveRecord::Base
    belongs_to :foodtruck
    
    mount_uploader :food_image, MenuImageUploader
end
