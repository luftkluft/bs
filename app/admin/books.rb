ActiveAdmin.register Book do
  permit_params :image, :title, :author, :category_id, :description, :year,
                :in_stock, :category_type, :materials, :price,
                :height, :width, :depth, :popularity, :visible,
                :image_1, :image_2, :image_3

  index do
    selectable_column
    id_column
    column 'Image' do |book|
      image_tag book.image.url, width: 80, height: 100
    end
    column :title
    column :author
    column 'Category' do |book|
      Category.find_by(id: book.category_id).category_type
    end
    column :description
    column :year
    column :in_stock
    column :popularity
    column :visible
    actions
  end

  filter :title
  filter :author
  filter :description
  filter :visible

  form do |f|
    f.inputs do
      f.input :image
      f.input :image_1
      f.input :image_2
      f.input :image_3
      f.input :title
      f.input :author
      f.input :category_id
      f.input :description
      f.input :materials
      f.input :price
      f.input :height
      f.input :width
      f.input :depth
      f.input :year
      f.input :in_stock
      f.input :popularity
      f.input :visible, as: :select, collection: [true, false]
    end
    f.actions
  end
end
