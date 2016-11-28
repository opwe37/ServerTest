class Review < ActiveRecord::Base
    belongs_to :client
    belongs_to :foodtruck
    has_many :comments
    
    mount_uploader :image, ReviewImageUploader
    
    def as_json(options = {})
        super(:only => [:id, :title, :content, :rating, :image, :updated_at],
            :include => {
                  :client => {:only => [:nickName, :image]}
            }
        )
    end
end
