class Job < ApplicationRecord
    belongs_to :user
    belongs_to :affiliate

    def full_street_address
 		[address,city,state].compact.join(',')
	end

	def get_location
    	geocoded_by :full_street_address
		after_validation :geocode
	end 
end
