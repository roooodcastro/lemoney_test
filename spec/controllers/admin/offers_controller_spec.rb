# frozen_string_literal: true

RSpec.describe Admin::OffersController do
  let(:offer) { FactoryBot.create :offer }

  describe 'Actions' do
    describe 'GET index' do
      before(:each) { get :index }

      it { expect(response.status).to eq 200 }
      it { is_expected.to render_template :index }

      it 'should return the existing offer' do
        offer
        expect(assigns[:offers]).to include offer
      end
    end

    describe 'GET new' do
      before(:each) { get :new }

      it { expect(response.status).to eq 200 }
      it { is_expected.to render_template :new }
      it { expect(assigns[:offer]).to be_a_new Offer }
    end

    describe 'GET edit' do
      before(:each) { get :edit, params: { id: offer.id } }

      it { expect(response.status).to eq 200 }
      it { is_expected.to render_template :edit }
      it { expect(assigns[:offer]).to eq offer }
    end

    describe 'POST create' do
      subject { post :create, params: { offer: offer_params } }

      let(:valid_offer_params) do
        { advertiser_name: Faker::Company.name, url: Faker::Internet.url,
          description: Faker::Lorem.sentence, starts_at: 1.day.ago }
      end

      let(:invalid_offer_params) { { advertiser_name: Faker::Company.name } }

      before(:each) { |spec| subject unless spec.metadata[:skip_before] }

      context 'When the params are correct' do
        let(:offer_params) { valid_offer_params }

        it { is_expected.to redirect_to admin_offers_path }
        it { expect(flash[:notice]).not_to be_blank }
        it { expect(flash.now[:error]).to be_blank }

        it 'should create an offer', skip_before: true do
          expect { subject }.to change(Offer, :count).by(1)
        end
      end

      context 'When the params are incorrect' do
        let(:offer_params) { invalid_offer_params }

        it { is_expected.to render_template :new }
        it { expect(flash[:notice]).to be_blank }
        it { expect(flash.now[:error]).not_to be_blank }

        it 'should not create an offer', skip_before: true do
          expect { subject }.not_to change(Offer, :count)
        end
      end
    end

    describe 'PATCH update' do
      subject { patch :update, params: { id: offer.id, offer: offer_params } }

      let(:offer) { FactoryBot.create :offer }
      let(:valid_offer_params) { { advertiser_name: Faker::Company.name } }
      let(:invalid_offer_params) { { advertiser_name: '' } }

      before(:each) { |spec| subject unless spec.metadata[:skip_before] }

      context 'When the params are correct' do
        let(:offer_params) { valid_offer_params }

        it { is_expected.to redirect_to admin_offers_path }
        it { expect(flash[:notice]).not_to be_blank }
        it { expect(flash.now[:error]).to be_blank }

        it 'should update offer', skip_before: true do
          old_name = offer.advertiser_name
          subject
          expect(offer.reload.advertiser_name).not_to eq old_name
        end
      end

      context 'When the params are incorrect' do
        let(:offer_params) { invalid_offer_params }

        it { is_expected.to render_template :edit }
        it { expect(flash[:notice]).to be_blank }
        it { expect(flash.now[:error]).not_to be_blank }

        it 'should not update offer', skip_before: true do
          old_name = offer.advertiser_name
          subject
          expect(offer.reload.advertiser_name).to eq old_name
        end
      end
    end

    describe 'DELETE destroy' do
      subject { delete :destroy, params: { id: offer_id } }

      before(:each) { |spec| subject unless spec.metadata[:skip_before] }

      context 'When the offer exists' do
        let(:offer_id) { offer.id }

        it { is_expected.to redirect_to admin_offers_path }
        it { expect(flash[:notice]).not_to be_blank }
        it { expect(flash[:error]).to be_blank }

        it 'should delete the offer', skip_before: true do
          offer
          expect { subject }.to change(Offer, :count).by(-1)
        end
      end

      context 'When the offer does not exist' do
        let(:offer_id) { 0 }

        it { is_expected.to redirect_to admin_offers_path }
        it { expect(flash[:notice]).to be_blank }
        it { expect(flash[:error]).not_to be_blank }

        it 'should delete any offer', skip_before: true do
          offer
          expect { subject }.not_to change(Offer, :count)
        end
      end
    end
  end
end
