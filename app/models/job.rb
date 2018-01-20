class Job < ApplicationRecord
    belongs_to :user
    belongs_to :affiliate, optional: true

    def full_street_address
 		[address,state,city].compact.join(',')
	end

	geocoded_by :full_street_address
	after_validation :geocode
	 
end
