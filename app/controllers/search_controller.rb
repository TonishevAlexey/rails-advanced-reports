class SearchController < ApplicationController
  skip_authorization_check

  def index
    search = SearchingService.new(search_params)
    search.call
    render json: { response: search.result}
  end

  private

  def search_params
    params.require(:search).permit(:q, :type)
  end
end
