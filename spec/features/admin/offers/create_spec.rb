# frozen_string_literal: true

RSpec.feature '.index admin/offers' do
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_manually user
    visit admin_offers_path
    click_link 'Create a new Offer'
  end

  scenario 'User can go back to the index' do
    click_link 'Back'
    expect(current_path).to eq admin_offers_path
  end

  scenario 'User can create an offer by filling the form correctly' do
    data = fill_in_offer_form_correctly
    click_button 'Save Offer'
    expect(current_path).to eq admin_offers_path
    expect(page).to have_content data[:advertiser_name]
  end

  scenario 'User cannot create an offer by filling the form incorrectly' do
    data = fill_in_offer_form_incorrectly
    click_button 'Save Offer'
    expect(current_path).to eq admin_offers_path
    expect(page).not_to have_content data[:advertiser_name]
  end
end
