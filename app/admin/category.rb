ActiveAdmin.register Category do
  permit_params :type_of

  index do
    selectable_column
    id_column
    column 'Category', &:type_of
    actions
  end

  filter :type_of

  form do |f|
    f.inputs do
      f.input :type_of
    end
    f.actions
  end
end
