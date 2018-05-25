class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @search = BuildingPermit.search_result(params[:days], params[:search], params[:distance])
    # @search = BuildingPermit.where(date_issued: (DateTime.now - params[:days].to_i)..(DateTime.now)).near(params[:search], params[:distance])
    @value = @search.sum(:valuation)
    @distance = params[:distance]
    @days = params[:days]


  end
end
