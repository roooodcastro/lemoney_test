# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :advertiser_name, :description, :url, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true

  scope :enabled, -> do
    where(disabled: false)
      .where('starts_at <= :time and (ends_at is null or ends_at >= :time)',
             time: Time.zone.now)
  end

  scope :newest_first, -> { order 'id desc' }

  # The test instructions state that an offer should be disable if:
  #
  # 3. when current time <= ends at, state = disabled
  #
  # I assumed this was incorrect and the instructions actually meant:
  #
  # when current time >= ends at, state = disabled
  #
  # Because there is no sense in disabling an offer before its end time.
  def enabled?
    return false if manually_disabled?
    started = starts_at <= Time.zone.now
    return started if ends_at.blank?
    started && ends_at >= Time.zone.now
  end

  def manually_disabled?
    attributes['disabled']
  end

  def disabled?
    !enabled?
  end
end
