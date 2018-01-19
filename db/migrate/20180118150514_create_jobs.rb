class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
    	t.string :name
    	t.string :category
    	t.date :start_date
    	t.time :start_time
    	t.string :description
    	t.integer :price
    	t.string :address
    	t.string :state
    	t.string :city
    	t.string :postcode
        t.references :user, foreign_key: true
    	t.references :affiliate, foreign_key: true
      
      t.timestamps
    end
  end
end
