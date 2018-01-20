# frozen_string_literal: true

require 'faker'

# Allows me to keep the test evaluator informed of what's going on :)
Rails.logger = Logger.new(STDOUT)

# Don't save anything if there's an error somewhere.
ActiveRecord::Base.transaction do
  # First we empty the database:
  Rails.logger.info 'Destroying all Offers...'
  Offer.destroy_all
  Rails.logger.info 'Destroying all Users...'
  User.destroy_all

  # Then we start creating some offers:
  # Offers without end dates
  Rails.logger.info 'Creating 15 Offers without ends_at date'
  15.times.each do
    Offer.create(advertiser_name: Faker::Company.name, url: Faker::Internet.url,
                 description: Faker::Lorem.sentence,
                 starts_at: Faker::Time.between(2.days.ago, 5.days.from_now,
                                                :midnight),
                 disabled: Random.rand > 0.7, premium: Random.rand > 0.8)
  end

  # Offers with end dates
  Rails.logger.info 'Creating 35 Offers with ends_at date'
  35.times.each do
    starts_at = Faker::Time.between(5.days.ago, 5.days.from_now, :midnight)
    ends_at = starts_at + Random.rand(8).days
    Offer.create(advertiser_name: Faker::Company.name, url: Faker::Internet.url,
                 description: Faker::Lorem.sentence,
                 starts_at: starts_at, ends_at: ends_at,
                 disabled: Random.rand > 0.8, premium: Random.rand > 0.7)
  end

  # Let's create an admin user:
  Rails.logger.info 'Creating Admin'
  User.create(username: 'Admin', email: 'admin@example.com',
              password: '123456')
end
