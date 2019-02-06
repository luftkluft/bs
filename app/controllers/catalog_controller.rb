class CatalogController < ApplicationController
  def show
    @category = Category.all || []
    @all_books = Book.all || []
    sorter ||= Sorter.new
    sorted_books = sorter.sortable(sortable_data)
    @pagy, @books = pagy(sorted_books, items: 8)
  end

  private

  def sortable_data
    { books_for_sorting: @all_books,
      by_category: catalog_params[:category_type_of],
      by_books_params: catalog_params[:books_sorting] }
  end

  def catalog_params
    params.permit(:category_type_of, :books_sorting, :page)
  end
end
