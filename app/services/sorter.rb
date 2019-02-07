class Sorter
  def sortable(sortable_data)
    books = sortable_data[:books_for_sorting]
    books = sort_by_category(books, sortable_data[:by_category]) if sortable_data[:by_category]
    books = sort_by_books_params(books, sortable_data[:by_books_params])
    books
  end

  def sort_by_category(books, category)
    books = books.where(category_id: Category.find_by(type_of: category).id)
    books
  rescue StandardError
    books
  end

  def sort_by_books_params(books, books_params)
    case books_params
    when 'Popular first'
      books = books.order(popularity: :desc)
    when 'Low to hight'
      books = books.order(price: :asc)
    when 'Hight to low'
      books = books.order(price: :desc)
    else books = books.order(year: :desc)
    end
    books
  end

  def last_three_books(books)
    return books if books.nil?

    books = books.order(created_at: :desc).limit(3)
    books
  end

  def bestsellers(books)
    return books if books.nil?

    books = best_from_category(books)
    books
  end

  private

  def best_from_category(books)
    best_books = []
    Category.all.each do |cat|
      book = books.where(category_id: cat.id).order(popularity: :desc).first
      best_books << book unless book.nil?
    end
    best_books
  end
end
