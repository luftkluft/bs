class CatalogController < ApplicationController
  def show
    @pagy, @books = pagy(Book.all, items: 8)
  end
end
