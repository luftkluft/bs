FactoryBot.define do
  factory :book do
    title { FFaker::Book.title + 'test book' }
    author { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
    category_id { rand(1..4) }
    price { format('%0.2f', rand(3..150.0)) }
    description { FFaker::Book.description }
    year { rand(1990..2018) }
    height { format('%0.1f', rand(5..9.0)) }
    width { format('%0.1f', rand(4..9.0)) }
    depth { format('%0.1f', rand(0.2..9.0)) }
    in_stock { rand(0..25) }
    popularity { rand(0..50) }
    materials { FFaker::Lorem.words(rand(1..5)).join(', ') }
    visible { true }
    image { '/app/assets/images/default_book_image.png' }
  end

  factory :test_book, class: Book do
    title { 'Test title' }
    author { 'Test Author' }
    category_id { 1 }
    price { 10.0 }
    description { 'Description' }
    year { 2019 }
    height { 3 }
    width { 2 }
    depth { 1 }
    in_stock { 10 }
    popularity { 5 }
    materials { 'Papear' }
    visible { true }
    image { '/app/assets/images/default_book_image.png' }
  end
end
