class Festival < ActiveRecord::Base
    belongs_to :client
    has_and_belongs_to_many :owners, -> { uniq }
end
