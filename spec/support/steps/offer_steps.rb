# frozen_string_literal: true

module OfferSteps
  def fill_in_offer_form_correctly
    data = random_offer_attributes
    fill_in Offer.human_attribute_name(:advertiser_name),
            with: data[:advertiser_name]
    fill_in Offer.human_attribute_name(:url), with: data[:url]
    fill_in Offer.human_attribute_name(:description), with: data[:description]
    fill_in Offer.human_attribute_name(:starts_at), with: data[:starts_at]
    data
  end

  def fill_in_offer_form_incorrectly
    data = random_offer_attributes
    fill_in Offer.human_attribute_name(:advertiser_name), with: ''
    fill_in Offer.human_attribute_name(:url), with: data[:url]
    fill_in Offer.human_attribute_name(:description), with: data[:description]
    data
  end

  def random_offer_attributes
    { advertiser_name: Faker::Company.name, url: Faker::Internet.url,
      description: Faker::Lorem.sentence, starts_at: 1.day.from_now }
  end
end
