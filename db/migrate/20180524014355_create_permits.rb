class CreatePermits < ActiveRecord::Migration[5.2]
  def change
    create_table :permits do |t|
      t.timestamp :date_issued
      t.string :permit_number
      t.string :address
      t.string :location
      t.string :class
      t.string :units
      t.integer :valuation
      t.integer :fee
      t.string :owner_name
      t.string :contractor_name
      t.references :permit_type, foreign_key: true

      t.timestamps
    end
  end
end
