class Sorter
  def sortable(sortable_data)
    books = sortable_data[:books_for_sorting]
    books = sort_by_category(books, sortable_data[:by_category]) if sortable_data[:by_category]
    books
  end

  def sort_by_category(books, category)
    books = books.where(category_id: Category.find_by(type_of: category).id)
    books
  rescue StandardError
    books
  end
end
