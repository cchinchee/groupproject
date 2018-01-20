# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

user={}
user['password'] = 'abcd'

ActiveRecord::Base.transaction do
	20.times do
		user['first_name'] = Faker::Name.first_name
		user['last_name'] = Faker::Name.last_name
		user['email'] = Faker::Internet.email
		user['phone'] = Faker::PhoneNumber.cell_phone
		user['address'] = Faker::Address.street_address
		user['city'] = Faker::Address.city
		user['state'] = Faker::Address.state
		user['postcode'] = Faker::Address.zip_code

		User.create(user)
	end
end

affiliate={}
affiliate['password'] = 'abcd'

ActiveRecord::Base.transaction do
	20.times do
		affiliate['first_name'] = Faker::Name.first_name
		affiliate['last_name'] = Faker::Name.last_name
		affiliate['email'] = Faker::Internet.email
		affiliate['phone'] = Faker::PhoneNumber.cell_phone
		affiliate['address'] = Faker::Address.street_address
		affiliate['city'] = Faker::Address.city
		affiliate['state'] = Faker::Address.state
		affiliate['postcode'] = Faker::Address.zip_code
		affiliate['verification_status'] = false
		affiliate['role'] = 0

		Affiliate.create(affiliate)
	end
end

job = {}
uids = []
aids = []
User.all.each { |u| uids << u.id }
Affiliate.all.each { |u| aids << u.id }

ActiveRecord::Base.transaction do
  2.times do 
    job['name'] = Faker::App.name
    job['category'] = ["Cooking","Tuition","Cleaning","Driving","Plumbing","Daycare"].sample
    job['start_date'] = Faker::Date.forward(1)
    job['start_time'] = Faker::Time.between(2.days.ago, Date.today, :day)
    job['description'] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    job['price'] = rand(100..1000)

    job['address'] = Faker::Address.street_address
    job['state'] = Faker::Address.state
    job['city'] = Faker::Address.city
    job['postcode'] = Faker::Address.zip_code

    job['user_id'] = uids.sample
    job['affiliate_id'] = aids.sample
    
    Job.create(job)
  end
end