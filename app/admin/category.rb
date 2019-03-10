ActiveAdmin.register Category do
  permit_params :category_type

  index do
    selectable_column
    id_column
    column 'Category', &:category_type
    actions
  end

  filter :category_type

  form do |f|
    f.inputs do
      f.input :category_type
    end
    f.actions
  end
end
