class CatalogController < ApplicationController
  def show
    @all_books = Book.where(visible: true)
    sorter = Sorter.new
    sorted_books = sorter.sortable(sortable_data)
    sort_by = sorter.view_books_params
    sort_by.nil? ? @sort_by = I18n.t('shared.sort_by') : @sort_by = sort_by
    @pagy, @books = pagy(sorted_books, items: 8)
  end

  private

  def sortable_data
    { books_for_sorting: @all_books,
      by_category: catalog_params[:category_category_type],
      by_books_params: catalog_params[:books_sorting] }
  end

  def catalog_params
    params.permit(:category_category_type, :books_sorting, :page)
  end
end
