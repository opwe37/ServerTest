class Review < ActiveRecord::Base
    belongs_to :client
    belongs_to :foodtruck
    
    mount_uploader :image, ReviewImageUploader
end
