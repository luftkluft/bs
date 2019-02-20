FactoryBot.define do
  factory :user do
    email { 'john.doe@example.com' }
    role { 'guest' }
    name { 'Cuest' }
  end

  factory :random_user, class: User do
    name { FFaker::Name.first_name }
    email { FFaker::Internet.safe_email }
    role { 'guest' }
  end
end
