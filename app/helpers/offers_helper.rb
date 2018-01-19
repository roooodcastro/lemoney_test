# frozen_string_literal: true

module OffersHelper
  def offer_status(offer)
    offer.enabled? ? 'enabled' : 'disabled'
  end

  def toggle_offer_status_button(offer)
    return enable_offer_button(offer) if offer.manually_disabled?
    disable_offer_button(offer)
  end

  def enable_offer_button(offer)
    form_for([:admin, offer], html: { class: 'w-100' }) do |f|
      concat f.hidden_field :disabled, value: false
      concat f.submit 'Enable', class: 'btn btn-success btn-block'
    end
  end

  def disable_offer_button(offer)
    form_for([:admin, offer], html: { class: 'w-100' }) do |f|
      concat f.hidden_field :disabled, value: true
      concat f.submit 'Disable', class: 'btn btn-warning btn-block'
    end
  end

  def offer_status_bg_color(offer)
    offer.enabled? ? '#ddffdd' : '#ffdddd'
  end
end
