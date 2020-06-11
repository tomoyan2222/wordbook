FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    original_name { 'test_user' }
    password { 'test1234' }
    password_confirmation { 'test1234' }
  end

  factory :wordbook do
    name { 'testbook' }
    category { '1' }
  end

  factory :word do
    name { 'test_word' }
    meaning { 'test_meaning' }
  end