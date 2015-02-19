 #     reviews GET       /reviews(.:format)                     reviews#index
 #             POST      /reviews(.:format)                     reviews#create
 # edit_review GET       /reviews/:id/edit(.:format)            reviews#edit
 #      review GET       /reviews/:id(.:format)                 reviews#show
 #             PATCH     /reviews/:id(.:format)                 reviews#update
 #             PUT       /reviews/:id(.:format)                 reviews#update
 #             DELETE    /reviews/:id(.:format)                 reviews#destroy

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :create]
  include WineApi

  def index
    #get dashboard
    @reviews = Review.all
  end

  def create
    #post a review, form from the wine info
    review = Review.new
    review.user_id = current_user.id
    review.product_id = params[:product_id]
    review.content = params[:content]

    if params[:positive]
      review.positive = eval(params[:positive])[:checked]
    else
      review.positive = false
    end

    review.save

    redirect_to :back
  end

  def edit
    #get edit form for review
    @review = Review.find_by({id: params[:id]})
  end

  def show
    #get individual reviews
    @review = Review.find_by({id: params[:id]})
    catalog = WineCatalog.new
    @product = catalog.id(@review.product_id)
  end

  def update
    #put/patch the review
    review = Review.find_by({id: params[:id]})
  end

  def destroy
    #delete the review
    review = Review.find_by({id: params[:id]})
  end

end
