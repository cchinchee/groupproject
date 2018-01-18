class CreateAffliates < ActiveRecord::Migration[5.1]
  def change
    create_table :affliates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :postcode
      t.string :state
      t.boolean :verification_status, default: false
      t.json :verification_documents
      t.boolean :role, default: false

      t.timestamps
    end
  end
end
