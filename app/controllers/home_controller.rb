class HomeController < ApplicationController
  def start_page
    @books = Book.all || []
    @last_book = Book.last || []
    @two_books = Book.take(2) || []
    @four_books = Book.take(4) || []
  end

  private

  def book_params
    params.require(:book).permit! # TODO
  end
end
