class BooksController < ApplicationController
  def show
    @category = Category.all || Category.new
    @book = Book.find(params[:id])
    @approved_reviews = @book.reviews.approved || [] # TODO
    @review = Review.new
  end

  # private

  # def book_params
  #   params.require(:book).permit! # TODO
  # end
end
