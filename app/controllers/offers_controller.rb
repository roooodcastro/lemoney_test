# frozen_string_literal: true

class OffersController < ApplicationController
  def index
    @offers = Offer.enabled.order_by_premium.order_by_remaining_time
  end
end
