class AddTypeAndType2AndType3ToPermitType < ActiveRecord::Migration[5.2]
  def change
    add_column :permit_types, :p_type, :string
    add_column :permit_types, :p_type_2, :string
    add_column :permit_types, :p_type_3, :string
  end
end
