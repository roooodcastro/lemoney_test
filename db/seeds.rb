# frozen_string_literal: true

require 'faker'

# Allows me to keep the test evaluator informed of what's going on :)
Rails.logger = Logger.new(STDOUT)

# Don't save anything if there's an error somewhere.
ActiveRecord::Base.transaction do
  # First we start creating some offers:
  # Offers without end dates
  Rails.logger.info 'Creating 5 Offers without ends_at date'
  5.times.each do
    Offer.create(advertiser_name: Faker::Company.name, url: Faker::Internet.url,
                 description: Faker::Lorem.sentence,
                 starts_at: Faker::Time.between(7.days.ago, 7.days.from_now,
                                                :midnight),
                 disabled: Random.rand > 0.7, premium: Random.rand > 0.8)
  end

  # Offers with end dates
  Rails.logger.info 'Creating 15 Offers with ends_at date'
  15.times.each do
    Offer.create(advertiser_name: Faker::Company.name, url: Faker::Internet.url,
                 description: Faker::Lorem.sentence,
                 starts_at: Faker::Time.between(7.days.ago, 7.days.from_now,
                                                :midnight),
                 ends_at: Faker::Time.between(7.days.from_now, 14.days.from_now,
                                              :midnight),
                 disabled: Random.rand > 0.7, premium: Random.rand > 0.8)
  end
end
