class Festival < ActiveRecord::Base
    
    def as_json(options = {})
        super.as_json(options).merge({applicant_num: cal_applicant})
    end
    
    def cal_applicant
        self.owners.count
    end
    
    belongs_to :client
    has_and_belongs_to_many :owners, -> { uniq }
end
