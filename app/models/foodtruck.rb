class Foodtruck < ActiveRecord::Base
    belongs_to :owner
    has_and_belongs_to_many :clients, -> { uniq }
    has_many :reviews
    
    acts_as_mappable :default_units => :kms
end