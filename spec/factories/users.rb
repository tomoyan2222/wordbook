FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    original_name { 'test_user' }
    password { 'password' }
  end

  factory :category do
    name { 'test_category' }
  end

  factory :title do
    name { 'testbook' }
    category_id { '1' }
    user_id { '1' }
  end

  factory :vocabulary do
    name { 'test_word' }
    meaning { 'test_meaning' }
  end
end