FactoryBot.define do
  factory :note do
    body { Faker::Lorem.paragraph }
    user { build(:user) }
    folder { build(:folder) }
  end
end
