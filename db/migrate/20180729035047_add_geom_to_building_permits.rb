class AddGeomToBuildingPermits < ActiveRecord::Migration[5.2]
  def change
    remove_column :building_permits, :geom, :st_point, :srid=>4326
    add_column :building_permits, :geom, :st_point, :srid=>4326
  end
end
