class CreateBuildingPermits < ActiveRecord::Migration[5.2]
  def change
    create_table :building_permits do |t|
      t.timestamp :date_issued
      t.string :permit_number
      t.string :address
      t.string :sublocation
      t.string :building_class
      t.integer :valuation
      t.integer :fee
      t.string :owner_name
      t.string :contractor_name
      t.references :permit_type, foreign_key: true
    end
  end
end
