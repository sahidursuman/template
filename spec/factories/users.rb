FactoryBot.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    username 'john'
    email 'john.doe@example.com'
    active true
  end

  factory :random_user, class: User do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    username {Faker::Name.first_name.downcase}
    email { Faker::Internet.safe_email }
    active true
  end
end