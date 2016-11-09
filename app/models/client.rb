class Client < ActiveRecord::Base
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
    has_secure_password
    
    #has_many :foodtrucks
    #belongs_to :foodtruck
    
    #has_many :likes
    #has_many :liked_foodtrucks, through: :foodtrucks, source: :foodtruck
    
    has_and_belongs_to_many :foodtrucks, -> { uniq }
    #has_many :reivews
end
