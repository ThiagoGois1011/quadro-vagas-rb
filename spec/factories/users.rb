FactoryBot.define do
  factory :user do
    email_address { 'joao@email.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end