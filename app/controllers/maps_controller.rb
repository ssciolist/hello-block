class MapsController < ApplicationController
  def index
    @home_marker = Geocoder.coordinates(params[:search])
    @presenter ||= BuildingPermitSearchPresenter.new(params[:days], params[:search], params[:distance])

  end

end
