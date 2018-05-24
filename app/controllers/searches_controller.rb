class SearchesController < ApplicationController
  def index
    @presenter = BuildingPermitSearchPresenter.new
  
  end
end
