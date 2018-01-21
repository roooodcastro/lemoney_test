# frozen_string_literal: true

RSpec.describe OffersHelper do
  describe '#offer_status' do
    subject { helper.offer_status(offer) }

    context 'When offer is enabled' do
      let(:offer) { FactoryBot.build :offer, :enabled }
      it { is_expected.to eq I18n.t('messages.offer.enabled_true') }
    end

    context 'When offer is disabled' do
      let(:offer) { FactoryBot.build :offer, :disabled_finished }
      it { is_expected.to eq I18n.t('messages.offer.enabled_false') }
    end
  end

  describe '#toggle_offer_status_button' do
    subject { helper.toggle_offer_status_button(offer) }

    context 'When offer is not manually disabled' do
      let(:offer) { FactoryBot.create :offer, :enabled }

      it { is_expected.to be_a String }

      it 'should return a form with a disable button' do
        is_expected.to have_tag('form', with: { action: admin_offer_path(offer),
                                                method: 'post' }) do
          with_tag(:input, with: { id: 'offer_disabled', type: 'hidden',
                                   value: true })
          with_tag(:input, with: { type: 'submit',
                                   value: I18n.t('messages.offer.disable') })
        end
      end
    end

    context 'When offer is manually disabled' do
      let(:offer) { FactoryBot.create :offer, :disabled_manually }

      it { is_expected.to be_a String }

      it 'should return a form with an enable button' do
        is_expected.to have_tag('form', with: { action: admin_offer_path(offer),
                                                method: 'post' }) do
          with_tag(:input, with: { id: 'offer_disabled', type: 'hidden',
                                   value: false })
          with_tag(:input, with: { type: 'submit',
                                   value: I18n.t('messages.offer.enable') })
        end
      end
    end
  end

  # Disabling this because I don't care about timezone precision at this point,
  # I'm just trying to mock the time to any random value.
  #
  # rubocop:disable Rails/Date
  describe '#offer_time_remaining' do
    subject { helper.offer_time_remaining(offer) }

    let(:offer) { FactoryBot.build :offer, ends_at: ends_at }
    let(:time) { Time.zone.today.to_time }

    before(:each) { allow(Time.zone).to receive(:now).and_return(time) }

    context 'When the offer does not have an end time' do
      let(:ends_at) { nil }

      it { is_expected.to be_blank }
    end

    context 'When the offer is set to end within the next 2 days' do
      let(:ends_at) { time + 23.hours }

      it { is_expected.to eq '23h:00m:00s' }
    end

    context 'When the offer is set to end in more than 2 days' do
      let(:ends_at) { time + 100.hours }

      it 'should return the correct time string' do
        is_expected.to eq I18n.t('datetime.distance_in_words.x_days.other',
                                 count: 3)
      end
    end
  end
  # rubocop:enable Rails/Date
end
