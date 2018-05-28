class AddWeeklyEmailToSavedSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :saved_searches, :weekly_email, :integer, default: 0
  end
end
