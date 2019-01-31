ActiveAdmin.register Review do
  permit_params :book_id, :user_id, :reviewer_name, :body,
                :state, :book, :user, :score

  index do
    selectable_column
    id_column
    column :book
    column :user
    column :reviewer_name
    column :body
    column :state
    column :score
    actions
  end

  filter :book
  filter :user
  filter :reviewer_name
  filter :body
  filter :state
  filter :score

  form do |f|
    f.inputs do
      f.input :book
      f.input :user
      f.input :reviewer_name
      f.input :body
      f.input :state
      f.input :score
    end
    f.actions
  end
end
