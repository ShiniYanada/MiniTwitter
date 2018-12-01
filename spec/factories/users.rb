FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    identifier{ 'yanasinn' }
    email { 'test@example.copm' }
    password { 'password' }
  end
end
