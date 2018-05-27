class CreateSavedSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_searches do |t|
      t.string :current_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
