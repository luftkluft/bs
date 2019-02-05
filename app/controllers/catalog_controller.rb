class CatalogController < ApplicationController
  def show
    @all_books = Book.all || []
    sorter ||= Sorter.new
    @category = Category.all || []
    sorted_books = sorter.sortable(sortable_data)
    @pagy, @books = pagy(sorted_books, items: 8)
  end

  private

  def sortable_data
    { books_for_sorting: @all_books,
      by_category: catalog_params[:category_type_of] }
  end

  def catalog_params
    params.permit(:category_type_of)
  end
end
