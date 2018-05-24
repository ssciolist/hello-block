class AddLatitudeAndLongitudeToBuildingPermit < ActiveRecord::Migration[5.2]
  def change
    add_column :building_permits, :latitude, :float
    add_column :building_permits, :longitude, :float
  end
end
