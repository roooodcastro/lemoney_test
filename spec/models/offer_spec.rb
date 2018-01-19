# frozen_string_literal: true

RSpec.describe Offer do
  subject { offer }
  let(:offer) { FactoryBot.build :offer }

  it { is_expected.to be_valid }

  describe 'Validations' do
    it { is_expected.to validate_presence_of :advertiser_name }
    it { is_expected.to validate_uniqueness_of :advertiser_name }
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :starts_at }
  end

  describe 'Scopes' do
    describe '#enabled' do
      subject { Offer.enabled }

      let!(:enabled_offer) { FactoryBot.create :offer, :enabled }
      let!(:disabled_offer) { FactoryBot.create :offer, :disabled_finished }

      it { is_expected.to be_an ActiveRecord::Relation }
      it { is_expected.to include enabled_offer }
      it { is_expected.not_to include disabled_offer }
    end

    describe '#newest_first' do
      subject { Offer.newest_first }

      let!(:older_offer) { FactoryBot.create :offer, id: 1 }
      let!(:newer_offer) { FactoryBot.create :offer, id: 2 }

      it { is_expected.to be_an ActiveRecord::Relation }
      it { expect(subject.to_a).to eq [newer_offer, older_offer] }
    end
  end

  describe 'Methods' do
    describe '#enabled?' do
      subject { offer.enabled? }

      let(:manual_disable) { false }
      let(:end_date) { nil }
      let(:offer) do
        FactoryBot.build :offer, disabled: manual_disable, starts_at: start,
                         ends_at: end_date
      end

      context 'When offer has not started yet' do
        let(:start) { 1.day.from_now }
        it { is_expected.to be_falsey }
      end

      context 'When offer has started and has no end date' do
        let(:start) { 1.day.ago }
        let(:end_date) { nil }
        it { is_expected.to be_truthy }
      end

      context 'When offer has started and has not yet finished' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.day.from_now }
        it { is_expected.to be_truthy }
      end

      context 'When offer has already finished' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.hour.ago }
        it { is_expected.to be_falsey }
      end

      context 'When offer should be active but was manually disabled' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.day.from_now }
        let(:manual_disable) { true }
        it { is_expected.to be_falsey }
      end
    end

    describe '#manually_disabled?' do
      subject { offer.manually_disabled? }

      let(:offer) { FactoryBot.build :offer, disabled: disabled }

      context 'When offer was not manually disabled' do
        let(:disabled) { false }
        it { is_expected.to be_falsey }
      end

      context 'When offer was manually disabled' do
        let(:disabled) { true }
        it { is_expected.to be_truthy }
      end
    end

    describe '#disabled?' do
      subject { offer.disabled? }

      let(:manual_disable) { false }
      let(:end_date) { nil }
      let(:offer) do
        FactoryBot.build :offer, disabled: manual_disable, starts_at: start,
                         ends_at: end_date
      end

      context 'When offer has not started yet' do
        let(:start) { 1.day.from_now }
        it { is_expected.to be_truthy }
      end

      context 'When offer has started and has no end date' do
        let(:start) { 1.day.ago }
        let(:end_date) { nil }
        it { is_expected.to be_falsey }
      end

      context 'When offer has started and has not yet finished' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.day.from_now }
        it { is_expected.to be_falsey }
      end

      context 'When offer has already finished' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.hour.ago }
        it { is_expected.to be_truthy }
      end

      context 'When offer should be active but was manually disabled' do
        let(:start) { 1.day.ago }
        let(:end_date) { 1.day.from_now }
        let(:manual_disable) { true }
        it { is_expected.to be_truthy }
      end
    end
  end
end
