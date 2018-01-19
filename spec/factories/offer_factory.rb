# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    description { Faker::Lorem.sentence }
    starts_at { 1.day.ago }

    trait :enabled do
      starts_at { 1.day.ago }
    end

    trait :disabled_not_started do
      starts_at { 1.day.from_now }
    end

    trait :disabled_finished do
      starts_at { 2.days.ago }
      ends_at { 1.day.ago }
    end

    trait :disabled_manually do
      starts_at { 1.day.ago }
      ends_at { 1.day.from_now }
      disabled true
    end

    trait :premium do
      premium true
    end
  end
end
