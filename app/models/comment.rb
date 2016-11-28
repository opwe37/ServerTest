class Comment < ActiveRecord::Base
    belongs_to :owner
    belongs_to :review
    
    def as_json(options = {})
        super(:except => [:created_at, :owner_id, :review_id])
    end
end
