class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @approved_reviews = @book.reviews.approved || [] # TODO
    @review = Review.new
  end

  # private

  # def book_params
  #   params.require(:book).permit! # TODO
  # end
end
