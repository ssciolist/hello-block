class CreatePermitType < ActiveRecord::Migration[5.2]
  def change
    create_table :permit_types do |t|
      t.string :name
    end
  end
end
