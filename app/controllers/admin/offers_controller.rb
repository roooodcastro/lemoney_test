# frozen_string_literal: true

class Admin
  class OffersController < ApplicationController
    before_action :authenticate_user!
    before_action :load_offer, only: [:show, :edit, :update]

    def index
      @offers = Offer.newest_first
    end

    def show; end

    def new
      @offer = Offer.new
    end

    def edit; end

    def create
      @offer = Offer.new(offer_params)
      created = @offer.save
      flash[:notice] = t('messages.offer.create_success') if created
      return redirect_to admin_offers_path if created
      flash.now[:error] = t('messages.offer.create_error',
                            errors: @offer.errors.full_messages.join(', '))
      render :new
    end

    def update
      updated = @offer.update_attributes(offer_params)
      flash[:notice] = t('messages.offer.update_success') if updated
      return redirect_to admin_offers_path if updated
      flash.now[:error] = t('messages.offer.update_error',
                            errors: @offer.errors.full_messages.join(', '))
      render :edit
    end

    def destroy
      Offer.find(params[:id]).destroy
      flash[:notice] = t('messages.offer.destroy_success')
    rescue ActiveRecord::RecordNotFound
      flash[:error] = t('messages.offer.destroy_error')
    ensure
      redirect_to admin_offers_path
    end

    private

    def load_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit([:advertiser_name, :url, :description,
                                     :starts_at, :ends_at, :premium, :disabled])
    end
  end
end
