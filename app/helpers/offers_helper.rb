# frozen_string_literal: true

module OffersHelper
  def offer_status(offer)
    offer.enabled? ? 'enabled' : 'disabled'
  end
end
