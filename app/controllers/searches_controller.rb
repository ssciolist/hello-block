class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @search = BuildingPermit.search_result(params[:days], params[:search], params[:distance])
    @address = params[:search]
    @value = @search.sum(:valuation)
    @distance = params[:distance]
    @days = params[:days]
    @permit_types = PermitType.all.pluck(:name)

  end
end
