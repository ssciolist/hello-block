class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @search = BuildingPermit.search_result(params[:days], params[:search], params[:distance])
    @address = params[:search]
    @value = @search.sum(:valuation)
    @distance = params[:distance]
    @days = params[:days]
  end
end
