class Sorter
  attr_accessor :view_books_params
  def initialize
    @view_books_params = ''
  end

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
    books = case books_params
            when I18n.t('services.sorter_popular_first')
              @view_books_params = books_params
              books.order(popularity: :desc)
            when I18n.t('services.sorter_low_to_hight')
              @view_books_params = books_params
              books.order(price: :asc)
            when I18n.t('services.sorter_hight_to_low')
              @view_books_params = books_params
              books.order(price: :desc)
            else
              @view_books_params = books_params
              books.order(year: :desc)
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
