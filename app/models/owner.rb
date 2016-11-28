class Owner < ActiveRecord::Base
    has_secure_password
    
    has_many :comments
    has_one :foodtruck
    has_and_belongs_to_many :festivals, -> { uniq }
end
