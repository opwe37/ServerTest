class Festival < ActiveRecord::Base
    
    belongs_to :client
    has_and_belongs_to_many :owners, -> { uniq }
    
    mount_uploader :image, FestivalImageUploader
    
    def as_json(options = {})
        super.as_json(options).merge({applicant_num: cal_applicant})
    end
    
    def cal_applicant
        self.owners.count
    end
    
    def self.end_festival_destroy
        @Festival = Festival.where('end_date < ?', (DateTime.now.days_ago(30)))
        
        @Festival.each { |festival|
            festival.destroy
        }
    end
    
end
