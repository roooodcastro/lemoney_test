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
  end

  context 'There are offers' do
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
