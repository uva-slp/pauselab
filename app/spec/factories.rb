FactoryGirl.define do

  factory :iteration do
    status 0
  end

  factory :category do
    name {Faker::Space.galaxy}
  end

  factory :idea do
    association :iteration
    association :category
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    phone {Faker::Number.number(10)}
    address {Faker::Address.street_address}
    lat {Faker::Address.latitude}
    lng {Faker::Address.longitude}
    description {Faker::Hipster.paragraph}
    likes {Faker::Number.number(3)}
  end

  factory :user do
    email {Faker::Internet.email}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    phone {Faker::Number.number(10)}
    password {Faker::Internet.password}
    # role "admin"

    factory :admin do
        after(:create, :build) {|user| user.change_role(:admin)}
    end
    factory :artist do
        after(:create, :build) {|user| user.change_role(:artist)}
    end
    factory :super_artist do
        after(:create, :build) {|user| user.change_role(:super_artist)}
    end
    factory :steerer do
        after(:create, :build) {|user| user.change_role(:steerer)}
    end
    factory :moderator do
        after(:create, :build) {|user| user.change_role(:moderator)}
    end
    factory :resident do
        after(:create, :build) {|user| user.change_role(:resident)}
    end

  end

  factory :proposal do
    association :iteration
    cost {Faker::Name.number(4)}
    description {Faker::Hipster.paragraph}
    essay {Faker::Hipster.paragraph}
    website_link "http://aaronbloomfield.github.io/slp/docs/index.html"
    artist_fees {Faker::Name.number(3)}
    project_materials {Faker::Name.between(10, 200)}
    printing {Faker::Name.between(10, 200)}
    marketing {Faker::Name.between(10, 200)}
    documentation {Faker::Name.between(10, 200)}
    volunteer {Faker::Name.between(10, 200)}
    insurance {Faker::Name.between(10, 200)}
    events {Faker::Name.between(10, 200)}
    title {Faker::Hipster.sentence}
  end

  factory :blog do
    association :iteration
    association :user
    title {Faker::Hipster.sentence}
    body {Faker::Hispter.paragraph}
  end

  factory :vote do
    association :iteration
    factory :vote_with_proposals do
      transient do
        languages_count 5
      end
      after(:create) do |profile, evaluator|
        create_list(:proposal, evaluator.languages_count, votes: [vote])
      end
    end
  end

end
