class CreateNeighborhoods < ActiveRecord::Migration[5.2]
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.multi_polygon :geom, :srid => 4326

    end
  end
end
