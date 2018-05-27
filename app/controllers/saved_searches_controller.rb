class SavedSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    saved_search = SavedSearch.new(current_url: params[:current_url], user_id: current_user.id)
    if saved_search.save
      flash[:success] = 'Added to your saved searches.'
      redirect_to "#{saved_search.current_url}"
    else
      flash[:warn] = 'Sorry, something went wrong'
    end
  end

  def destroy
    saved_search = SavedSearch.find(params[:id])
    saved_search.destroy
    redirect_to user_path(current_user)
  end
end
