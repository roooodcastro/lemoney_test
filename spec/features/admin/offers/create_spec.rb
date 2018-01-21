# frozen_string_literal: true

RSpec.feature '.create admin/offers' do
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_manually user
    visit admin_offers_path
    click_link I18n.t('messages.offer.new_button')
  end

  scenario 'User can go back to the index' do
    click_link I18n.t('messages.back')
    expect(current_path).to eq admin_offers_path
  end

  scenario 'User can create an offer by filling the form correctly' do
    data = fill_in_offer_form_correctly
    click_button I18n.t('messages.offer.save')
    expect(current_path).to eq admin_offers_path
    expect(page).to have_content data[:advertiser_name]
  end

  scenario 'User cannot create an offer by filling the form incorrectly' do
    data = fill_in_offer_form_incorrectly
    click_button I18n.t('messages.offer.save')
    expect(current_path).to eq admin_offers_path
    expect(page).not_to have_content data[:advertiser_name]
  end
end
