require 'ffaker'
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')

  User.create!(email: 'user@example.com',
               password: 'password',
               password_confirmation: 'password')

  category_type = ['Web design',
                   'Mobile development',
                   'Databases',
                   'Web development']
  category_type.each { |type| Category.create!(category_type: type) }

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
  Coupon.create!(code: '12345', percent: 5.0, value: 6.0)
  Coupon.create!(code: '54321', percent: 2.0, value: 3.55)
  Delivery.create!(method: FFaker::Company.name, duration: '5 days', price: 10.30)
  Delivery.create!(method: FFaker::Company.name, duration: '15 days', price: 25.50)
  Delivery.create!(method: FFaker::Company.name, duration: '20 days', price: 40.99)
