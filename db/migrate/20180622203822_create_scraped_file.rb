class CreateScrapedFile < ActiveRecord::Migration[5.2]
  def change
    create_table :scraped_files do |t|
      t.string :url
    end
  end
end
