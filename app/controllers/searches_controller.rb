class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @search = BuildingPermit.near(params[:search], params[:distance])
    @value = @search.sum(:valuation)
    @distance = params[:distance]
    @days = params[:days]


  end
end
