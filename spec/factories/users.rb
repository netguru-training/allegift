FactoryGirl.define do
  factory :user do
    email { 'johndoe@gmail.com' }
    password 'password123'
  end
end