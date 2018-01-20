# frozen_string_literal: true

RSpec.feature '.update admin/offers' do
  let(:offer) { FactoryBot.create :offer }
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_manually user
    offer
    visit admin_offers_path
    click_link 'Edit'
  end

  scenario 'User can go back to the index' do
    click_link 'Back'
    expect(current_path).to eq admin_offers_path
  end

  scenario 'User can update an offer by filling the form correctly' do
    data = fill_in_offer_form_correctly
    click_button 'Save Offer'
    expect(current_path).to eq admin_offers_path
    expect(page).to have_content data[:advertiser_name]
    expect(page).not_to have_content offer.advertiser_name
  end

  scenario 'User cannot update an offer by filling the form incorrectly' do
    data = fill_in_offer_form_incorrectly
    click_button 'Save Offer'
    expect(current_path).to eq admin_offer_path(offer)
    expect(page).not_to have_content data[:advertiser_name]
    expect(page).to have_selector 'form'
  end
end
