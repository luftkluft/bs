class BooksController < ApplicationController
  def show
    @book = Book.find(book_params[:id])
    @approved_reviews = @book.reviews.approved || []
    @review = Review.new
  end

  private

  def book_params
    params.permit(:controller, :action, :id)
  end
end
