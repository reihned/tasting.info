class WinesController < ApplicationController
  #                  wines GET       /wines(.:format)                       wines#index
  #                        POST      /wines(.:format)                       wines#create
  #                   wine GET       /wines/:id(.:format)                   wines#show
  
  include WineAPI

  def index
    # search form
  end

  def create
    #create a new search, post from index

  end

  def show
    # each wine page

  end

end
