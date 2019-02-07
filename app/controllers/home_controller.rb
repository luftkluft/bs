class HomeController < ApplicationController
  def start_page
    sorter ||= Sorter.new
    @all_books = Book.all
    @last_three_books = sorter.last_three_books(@all_books)
    @bestsellers = sorter.bestsellers(@all_books)
  end

  private

  def home_params
    params.permit! # TODO
  end
end
