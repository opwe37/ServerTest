class Like < ActiveRecord::Base
    belongs_to :client
    belongs_to :foodtruck
end
