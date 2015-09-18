FactoryGirl.define do
  sequence(:nickname) { FFaker::Name.first_name }
  sequence(:email) { FFaker::Internet.email }
  sequence(:password) { FFaker::Internet.password(8) }
  sequence(:text) { FFaker::Lorem.characters(8) }
  sequence(:image) { FFaker::Avatar.image }

  factory :user do |user|
    user.nickname { generate :nickname}
    user.email { generate :email }
    user.password { generate :password}
    password_confirmation(&:password)

    factory :user_with_tweets do
      transient do
        tweets_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:tweet, evaluator.tweets_count, user: user)
      end
    end
  end

  factory :tweet do |tweet|
    tweet.text { generate :text }
    tweet.image { generate :image }
    user
  end
end