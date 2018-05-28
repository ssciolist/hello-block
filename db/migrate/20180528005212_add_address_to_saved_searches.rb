class AddAddressToSavedSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :saved_searches, :address, :string
  end
end
