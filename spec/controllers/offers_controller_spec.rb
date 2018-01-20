# frozen_string_literal: true

RSpec.describe OffersController do
  let!(:offer) { FactoryBot.create :offer }

  describe 'Actions' do
    describe 'GET index' do
      before(:each) { get :index }

      it { expect(response.status).to eq 200 }
      it { is_expected.to render_template :index }
      it { expect(assigns[:offers]).to include offer }
    end
  end
end
