class Menu < ActiveRecord::Base
    belongs_to :foodtruck
    
    mount_uploader :image, MenuImageUploader
end
