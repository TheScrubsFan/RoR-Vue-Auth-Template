FactoryBot.define do
  factory :user do
    password { 'qwerty123456' }
    email { Faker::Internet.email }
    name { Faker::Name.first_name }

    factory :invalid_user do
      email nil
    end
  end
end
