FactoryBot.define do
  factory :job_posting do
    title { "Dev Ruby on Rails" }
    company_profile
    salary { "3000" }
    salary_currency { "USD" }
    salary_period { "Mensalmente" }
  end
end
