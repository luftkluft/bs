FactoryBot.define do
  factory :billing_address, class: Address do
    address_type { 'billing' }
    first_name { 'FirstName' }
    last_name { 'LastName' }
    address { 'Address' }
    city { 'City' }
    country { 'Country' }
    zip { '12345' }
    phone { '+1234567' }
  end

  factory :shipping_address, class: Address do
    address_type { 'shipping' }
    first_name { 'FirstName' }
    last_name { 'LastName' }
    address { 'Address' }
    city { 'City' }
    country { 'Country' }
    zip { '12345' }
    phone { '+1234567' }
  end
end
