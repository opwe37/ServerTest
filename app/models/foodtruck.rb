class Foodtruck < ActiveRecord::Base
    #has_many :clients
    #belongs_to :client
    
    #has_many :likes
    #has_many :likes_clients, through: :likes, source: :client
    
    has_and_belongs_to_many :clients, -> { uniq }
    has_many :reviews
end
 
