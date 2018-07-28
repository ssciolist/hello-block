class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  def show
    render json: NeighborhoodPresenter.new(permit_class, year).geojson_summary
  end

  private

  def year
    ## current design allows for all years or one year. Would be good to change for 2-3 year selection
    array = params[:years].split(',')
    if array.length == 4
      ''
    else
      array[0].to_i
    end
  end

  def permit_class
    params[:class]
  end
end
