FactoryGirl.define do

  factory :user do
    name { Faker::Name.name }
    avatar { Faker::Avatar.image }
    email { Faker::Internet.email }
    password { Faker::Internet.password(6, 20) }
  end

  factory :keyword do
    text { Faker::Hipster.sentence(2) }
    total_links_count { Faker::Number.between(50, 150) }
    non_adwords_count { Faker::Number.between(5, 10) }
    adwords_count { Faker::Number.between(0, 10) }
    total_result { Faker::Number.between(1, 10) }
  end

  # Door keeper factory
  factory :application, class: Doorkeeper::Application do
    name { Faker::Hipster.word.capitalize }
    redirect_uri { Faker::Internet.url }
  end

  factory :access_token, class: Doorkeeper::AccessToken do
    application
    association :resource_owner, factory: :user
  end

end
