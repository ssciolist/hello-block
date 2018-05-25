class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
    @value = BuildingPermit.near(params[:search]).sum(:valuation)
    

  end
end
