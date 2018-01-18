# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :advertiser_name, :description, :url, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true

  scope :enabled, -> do
    where(disabled: false)
      .where('starts_at <= :time && (ends_at == null or ends_at >= :time',
             time: Time.zone.now)
  end

  def toggle_manual_disable!
    self.disabled = !disabled
    save!
  end

  def enabled?
    return false if disabled
    started = starts_at <= Time.zone.now
    return started if ends_at.blank?
    started && ends_at >= Time.zone.now
  end

  def disabled?
    !enabled?
  end
end
