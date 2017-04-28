class ReviewsController < ApplicationController
  
  def create
  	@review = current_user.reviews.create(review_params)
  	redirect_to @review.listing
  end

  def destroy
  	@review = Review.find(params[:id])
  	listing = @review.listing
  	@review.destroy
  	redirect_to listing
  end

  private
  	def review_params
  		params.require(:review).permit(:description, :rate, :listing_id)
  	end

end