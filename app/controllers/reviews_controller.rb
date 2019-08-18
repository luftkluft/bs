class ReviewsController < ApplicationController
  def create
    @review = Review.create(review_params)
    if @review
      flash[:notice] = I18n.t('review.create.success')
    else
      flash[:alert] = I18n.t('review.create.failure')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.permit(:score, :body, :book_id, :user_id)
  end
end
