FactoryBot.define do
  factory :user do
    password { 'qwerty123456' }
    email { Faker::Internet.email }
    name { Faker::Name.first_name }

    factory :without_email do
      email nil
    end

    factory :without_password do
      password nil
    end
  end
end
