class AddGeomToBuildingPermits < ActiveRecord::Migration[5.2]
  def change
    add_column :building_permits, :geom, :point, :srid => 4326
  end
end
