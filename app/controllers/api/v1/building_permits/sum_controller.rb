class Api::V1::BuildingPermits::SumController < ApplicationController
  def show
    require 'pry'; binding.pry
    if params[:group] == "years"
      render json: BuildingPermit.select('SUM(valuation) AS total').where("permit_number LIKE '2018-RESCON%'")
    else
      # here's where a design for an aggregation by month would go. Potential to agg by other attrbs as well
    end
  end
end
