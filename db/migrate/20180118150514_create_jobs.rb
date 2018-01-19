class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
    	t.string :name
    	t.string :category
    	t.date :start_date
    	t.date :end_date
    	t.string :description
    	t.integer :price
    	t.string :review
    	t.string :address
    	t.string :state
    	t.string :city
    	t.string :postcode
    	t.integer :user_id
    	t.integer :affiliates_id

      	t.timestamps
    end
  end
end
