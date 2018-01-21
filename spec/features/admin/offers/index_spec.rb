# frozen_string_literal: true

RSpec.feature '.index admin/offers' do
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_manually user
    offer
    visit admin_offers_path
  end

  context 'There are no offers' do
    let(:offer) { nil }

    scenario 'User sees message indicating that there is no offer created' do
      expect(page).to have_content(I18n.t('messages.offers'))
      expect(page).to have_tag(:div, with: { class: 'alert' }) do
        with_tag(:a, with: { href: new_admin_offer_path })
      end
    end

    scenario 'User can go to new offer page' do
      click_link I18n.t('messages.offer.new_button')
      expect(current_path).to eq new_admin_offer_path
    end
  end

  context 'There are enabled offers' do
    let(:offer) { FactoryBot.create :offer }

    scenario 'User sees existing offers' do
      expect(page).to have_content(I18n.t('messages.offers'))
      disable = I18n.t('messages.offer.disable')
      within('table tbody tr') do
        expect(page).to have_content offer.advertiser_name
        expect(page).to have_content I18n.t('messages.edit')
        expect(page).to have_selector("input[type=submit][value='#{disable}']")
        expect(page).to have_content I18n.t('messages.destroy')
      end
    end

    scenario 'User can go to edit page' do
      within('table tbody tr') do
        click_link I18n.t('messages.edit')
        expect(current_path).to eq edit_admin_offer_path(offer)
      end
    end

    scenario 'User can destroy an offer', js: true do
      within('table tbody tr') do
        click_link I18n.t('messages.destroy')
      end
      expect(current_path).to eq admin_offers_path
      expect(page).not_to have_selector('table tbody tr')
      expect(page).not_to have_content offer.advertiser_name
    end
  end

  context 'There are disabled offers' do
    let(:offer) { FactoryBot.create :offer, :disabled_manually }

    scenario 'User sees existing offers' do
      expect(page).to have_content(I18n.t('messages.offers'))
      enable = I18n.t('messages.offer.enable')
      within('table tbody tr') do
        expect(page).to have_content offer.advertiser_name
        expect(page).to have_content I18n.t('messages.edit')
        expect(page).to have_selector("input[type=submit][value='#{enable}']")
        expect(page).to have_content I18n.t('messages.destroy')
      end
    end
  end
end
