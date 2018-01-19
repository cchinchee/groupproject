class Affiliate < ApplicationRecord
	has_secure_password
	has_many :jobs
	has_many :training_courses
end
