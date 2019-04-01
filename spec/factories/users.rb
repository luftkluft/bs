FactoryBot.define do
  factory :user do
    email { 'user@example.com' }
    role { 'guest' }
    name { 'Cuest' }
    uid { '' }
    provider { '' }
  end

  factory :random_user, class: User do
    name { FFaker::Name.first_name }
    email { FFaker::Internet.safe_email }
    role { 'guest' }
    uid { '' }
    provider { '' }
  end
end
