require 'ffaker'
if Rails.env.development?
  # AdminUser.delete_all
  # User.delete_all
  # Category.delete_all
  # Book.delete_all

  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')

  User.create!(email: 'user@example.com',
               password: 'password',
               password_confirmation: 'password')

  type_of = ['Web design',
             'Mobile development',
             'Databases',
             'Web development']
  type_of.each { |type| Category.create!(type_of: type) }

  books = []

  15.times do |item|
    books << {
      title: FFaker::Book.title + item.to_s,
      author: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}",
      category_id: rand(1..4),
      price: format('%0.2f', rand(3..150.0)),
      description: FFaker::Book.description,
      year: rand(1990..2018),
      height: format('%0.1f', rand(5..9.0)),
      width: format('%0.1f', rand(4..9.0)),
      depth: format('%0.1f', rand(0.2..9.0)),
      in_stock: rand(0..25),
      materials: FFaker::Lorem.words(rand(1..5)).join(', ')
      # image: "/app/assets/images/default_book_image.png"
    }
  end

  Book.create!(books)
end

if Rails.env.production?
  # AdminUser.delete_all
  # User.delete_all
  # Category.delete_all
  # Book.delete_all

  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')

  # User.create!(email: 'user@example.com',
  #              password: 'password',
  #              password_confirmation: 'password')

  type_of = ['Web design',
             'Mobile development',
             'Databases',
             'Web development']
  type_of.each { |type| Category.create!(type_of: type) }

  books = []

  15.times do |item|
    books << {
      title: FFaker::Book.title + item.to_s,
      author: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}",
      category_id: rand(1..4),
      price: format('%0.2f', rand(3..150.0)),
      description: FFaker::Book.description,
      year: rand(1990..2018),
      height: format('%0.1f', rand(5..9.0)),
      width: format('%0.1f', rand(4..9.0)),
      depth: format('%0.1f', rand(0.2..9.0)),
      in_stock: rand(0..25),
      popularity: rand(0..50),
      materials: FFaker::Lorem.words(rand(1..5)).join(', ')
      # image: "/app/assets/images/default_book_image.png"
    }
  end

  Book.create!(books)
end
