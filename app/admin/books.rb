ActiveAdmin.register Book do
  permit_params :image, :title, :author, :category_id, :description, :year,
                :in_stock, :type_of, :materials, :price,
                :height, :width, :depth

  index do
    selectable_column
    id_column
    column 'Image' do |book|
      image_tag book.image.url, width: 80, height: 100
    end
    column :title
    column :author
    column 'Category' do |book|
      Category.find_by(id: book.category_id).type_of
    end
    column :description
    column :year
    column :in_stock
    column :visible
    actions
  end

  filter :title
  filter :author
  filter :description
  filter :visible
end
