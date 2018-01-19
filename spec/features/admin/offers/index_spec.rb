# frozen_string_literal: true

RSpec.feature '.index admin/offers' do
  before(:each) do
    offer
    visit admin_offers_path
  end

  context 'There are no offers' do
    let(:offer) { nil }

    scenario 'User sees message indicating that there is no offer created' do
      expect(page).to have_content('Existing Offers')
      expect(page).to have_tag(:div, with: { class: 'alert' }) do
        with_tag(:a, with: { href: new_admin_offer_path })
      end
    end

    scenario 'User can go to new offer page' do
      click_link 'Create a new Offer'
      expect(current_path).to eq new_admin_offer_path
    end
  end

  context 'There are enabled offers' do
    let(:offer) { FactoryBot.create :offer }

    scenario 'User sees existing offers' do
      expect(page).to have_content('Existing Offers')
      within('table tbody tr') do
        expect(page).to have_content offer.advertiser_name
        expect(page).to have_content 'Edit'
        expect(page).to have_selector("input[type=submit][value='Disable']")
        expect(page).to have_content 'Destroy'
      end
    end

    scenario 'User can go to edit page' do
      within('table tbody tr') do
        click_link 'Edit'
        expect(current_path).to eq edit_admin_offer_path(offer)
      end
    end

    scenario 'User can destroy an offer', js: true do
      within('table tbody tr') do
        click_link 'Destroy'
      end
      expect(current_path).to eq admin_offers_path
      expect(page).not_to have_selector('table tbody tr')
      expect(page).not_to have_content offer.advertiser_name
    end
  end

  context 'There are disabled offers' do
    let(:offer) { FactoryBot.create :offer, :disabled_manually }

    scenario 'User sees existing offers' do
      expect(page).to have_content('Existing Offers')
      within('table tbody tr') do
        expect(page).to have_content offer.advertiser_name
        expect(page).to have_content 'Edit'
        expect(page).to have_selector("input[type=submit][value='Enable']")
        expect(page).to have_content 'Destroy'
      end
    end
  end
end
