class HomeController < ApplicationController
  def start_page
    sorter = Sorter.new
    @visible_books = Book.where(visible: true)
    @last_three_books = sorter.last_three_books(@visible_books)
    @bestsellers = sorter.bestsellers(@visible_books)
  end
end
