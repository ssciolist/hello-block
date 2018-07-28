class NeighborhoodService

  def initialize(permit_class, years)
    @class = permit_class
    @years = years
  end

  def summarize
    if @years.length == 4
      ActiveRecord::Base.connection.execute(sql_q(''))
    elsif @years.length == 1
      resultb = ActiveRecord::Base.connection.execute(sql_q(@years[0]))
    end
  end

  private

  def sql_q(years)
    "SELECT json_build_object(
      'type', 'FeatureCollection',
      'crs',  json_build_object('type','name', 'properties', json_build_object('name', 'EPSG:4326')
      ),
      'features', json_agg(
        json_build_object(
          'type', 'Feature',
           'geometry',   ST_AsGeoJSON(geom)::json,
           'properties', json_build_object(
             'id', d.nbhd_id,
             'name', d.nbhd_name,
             'total', nbhd_sums.sum)
             )
            )
          )
        FROM denver_neighborhoods d
        INNER JOIN (
          SELECT d.nbhd_name AS name, SUM(bp.valuation) AS sum
          FROM denver_neighborhoods d, building_permits bp
          WHERE ST_Intersects(d.geom, bp.geom) AND bp.permit_number LIKE '#{years}%'
          GROUP BY d.nbhd_name
          ) nbhd_sums
          ON nbhd_sums.name = d.nbhd_name;"
  end

end
