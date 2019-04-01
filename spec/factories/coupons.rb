FactoryBot.define do
  factory :coupon do
    code { '12345' }
    percent { 3.0 }
    value { 5.0 }
  end
end
