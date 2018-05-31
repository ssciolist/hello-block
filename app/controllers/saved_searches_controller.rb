class SavedSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    saved_search = SavedSearch.new(current_url: params[:current_url], user_id: current_user.id)
    if saved_search.save
      flash[:success] = "Added to your saved searches. See #{view_context.link_to('all your searches', user_path(current_user))}".html_safe
      redirect_to "#{saved_search.current_url}"
    else
      flash[:warn] = 'Sorry, something went wrong'
    end
  end

  def show
    @saved_search = SavedSearch.find(params[:id])
  end

  def update
    saved_search = SavedSearch.find(params[:id])
    if saved_search.weekly_email == 'no'
      saved_search.update(weekly_email: 'yes')
    else
      saved_search.update(weekly_email: 'no')
    end
    require 'pry'; binding.pry
    redirect_to user_saved_search_path(saved_search)
  end

  def destroy
    saved_search = SavedSearch.find(params[:id])
    saved_search.destroy
    redirect_to user_path(current_user)
  end
end
