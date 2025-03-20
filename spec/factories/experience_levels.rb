FactoryBot.define do
  factory :experience_level do
    name do
      available_names = [ "Intern", "Junior", "Mid-level", "Senior" ] - ExperienceLevel.pluck(:name)
      available_names.sample || raise("Sem valores disponíveis para name")
    end
    status { :active }
  end
end
