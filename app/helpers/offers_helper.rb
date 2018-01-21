# frozen_string_literal: true

module OffersHelper
  def offer_status(offer)
    t("messages.offer.enabled_#{offer.enabled?}")
  end

  def toggle_offer_status_button(offer)
    return enable_offer_button(offer) if offer.manually_disabled?
    disable_offer_button(offer)
  end

  def enable_offer_button(offer)
    form_for([:admin, offer], html: { class: 'w-100' }) do |f|
      concat f.hidden_field :disabled, value: false
      concat f.submit t('messages.offer.enable'),
                      class: 'btn btn-success btn-block'
    end
  end

  def disable_offer_button(offer)
    form_for([:admin, offer], html: { class: 'w-100' }) do |f|
      concat f.hidden_field :disabled, value: true
      concat f.submit t('messages.offer.disable'),
                      class: 'btn btn-warning btn-block'
    end
  end

  def offer_time_remaining(offer)
    return unless offer.ends_at
    seconds_to_end = offer.ends_at - Time.zone.now
    return seconds_to_time(seconds_to_end) if seconds_to_end < 2.days
    distance_of_time_in_words_to_now(offer.ends_at)
  end
end
