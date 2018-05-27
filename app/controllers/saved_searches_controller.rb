class SavedSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    saved_search = SavedSearch.create(url: params[:current_url], user_id: current_user.id)
    flash[:success] = 'Added to your saved searches.'
    redirect_to "#{saved_search.url}"
  end

  def destroy
    saved_search = SavedSearch.find(params[:id])
    saved_search.destroy
    redirect_to user_path(current_user)
  end
end
