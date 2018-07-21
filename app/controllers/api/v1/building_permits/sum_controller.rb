class Api::V1::BuildingPermits::SumController < ApplicationController
  def show
    if params[:group] == "years"

      years_with_valuation = years_array.reduce(Hash.new(0)) do |year_hash, year|
        year_hash[year] += BuildingPermit.where("permit_number LIKE '#{year}-#{params[:class]}%'").sum(:valuation)
        year_hash
      end
      render json: years_with_valuation
    else
      # here's where a design for an aggregation by month would go. Potential to agg by other attrbs as well
    end
  end

  private

  def years_array
    params[:years].split(',')
  end
end
