class SearchController < ApplicationController
  def index
  @querystring = params[:query]
  @type = params[:type]
  
  end
  
  
end
