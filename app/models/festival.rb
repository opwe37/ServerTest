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
        @Festival = Festival.where('end_date < ?', (DateTime.now.days_ago(14)))
        
        @Festival.each { |festival|
            festival.destroy
        }
    end
    
    def self.change_status
        @Festival = Festival.where(:status => 0).where('? < applicant_start', DateTime.now)
        @Festival.each { |festival|
            festival.status = 1
            festival.save
        }
        
        @Festival = Festival.where(:status => 1).where('applicant_end < ? AND ? < end_date', DateTime.now)
        @Festival.each { |festival|
            festival.status = 2
            festival.save
        }
        
        @Festival = Festival.where(:status => 2).where('end_date < ?', DateTime.now)
        @Festival.each { |festival|
            festival.status = 3
            festival.save
        }
    end
end
