FactoryBot.define do
  factory :note do
    body { Faker::Lorem.paragraph }
    user { build(:user) }
    folder { build(:folder) }
    file { Rack::Test::UploadedFile.new('spec/fixtures/files/video.mp4') }
  end
end
