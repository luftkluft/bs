FactoryBot.define do
  # type_of_category = ['Web design',
  # 'Mobile development',
  # 'Databases',
  # 'Web development']
  # type_of_category.each do |type|
    factory :category do
      type_of {'test category'}
    end
  # end
end