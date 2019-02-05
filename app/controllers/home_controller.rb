class HomeController < ApplicationController
  def start_page
    @category = Category.all || []
    @books = Book.all || Book.new
    @last_book = Book.last || Book.new
    @two_books = Book.take(2) || Book.new
    @four_books = Book.take(4) || Book.new
  end

  private

  def book_params
    params.require(:book).permit! # TODO
  end
end
