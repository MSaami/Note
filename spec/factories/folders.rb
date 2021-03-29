FactoryBot.define do
  factory :folder do
    user { build(:user) }
    name { Faker::Name.name }
  end
end
