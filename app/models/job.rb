class Job < ApplicationRecord
    belongs_to :user
    belongs_to :affiliate, optional: true
    enum status: { pending: 0, accepted: 1, paid: 2, completed: 3}

    def full_street_address
 			[address,postcode,city,state].compact.join(',')
		end

	geocoded_by :full_street_address
	after_validation :geocode
	 
end
