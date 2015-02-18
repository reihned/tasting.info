 #     reviews GET       /reviews(.:format)                     reviews#index
 #             POST      /reviews(.:format)                     reviews#create
 # edit_review GET       /reviews/:id/edit(.:format)            reviews#edit
 #      review GET       /reviews/:id(.:format)                 reviews#show
 #             PATCH     /reviews/:id(.:format)                 reviews#update
 #             PUT       /reviews/:id(.:format)                 reviews#update
 #             DELETE    /reviews/:id(.:format)                 reviews#destroy

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :create]

  def index
    #get
    @reviews = Review.all
  end

  def create
    #post
  end

  def edit
    #get
    @review = Review.find_by(params[:id])
  end

  def show
    #get
    @review = Review.find_by(params[:id])
  end

  def update
    #put/patch
    review = Review.find_by(params[:id])
  end

  def destroy
    #delete
    review = Review.find_by(params[:id])
  end

end
