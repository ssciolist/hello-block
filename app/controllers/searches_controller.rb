class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @search = BuildingPermit.near(params[:search], params[:distance])
    @value = BuildingPermit.near(params[:search], params[:distance]).sum(:valuation)
    @distance = params[:distance]


  end
end
