class Neighborhood < ApplicationRecord
  before_save :set_geom

  private

  def set_geom
    st_srid(st_astext(self.geom))
  end
end
