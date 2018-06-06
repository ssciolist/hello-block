class SearchesController < ApplicationController
  def index
    @presenter ||= BuildingPermitSearchPresenter.new(params[:days], params[:search], params[:distance])
    @search = Kaminari.paginate_array(@presenter.search_results).page(params[:page]).per(10)
  end
end
