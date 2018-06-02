class SearchesController < ApplicationController
  def index
    @presenter ||= BuildingPermitSearchPresenter.new(params[:days], params[:search], params[:distance])
    @search = BuildingPermit.paginate(:page => params[:page], :per_page => 20)
  end
end
