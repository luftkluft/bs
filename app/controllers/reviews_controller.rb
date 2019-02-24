class ReviewsController < ApplicationController
  def create
    @review = Review.create(review_params)
    if @review
      flash[:notice] = 'Thanks for review. It will be published as soon as Admin approve it!'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Review not created!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.permit(:score, :body, :book_id, :user_id)
  end
end
