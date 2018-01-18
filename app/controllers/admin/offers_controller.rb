# frozen_string_literal: true

class Admin
  class OffersController < ApplicationController
    before_action :load_offer, only: [:show, :edit, :update, :destroy]

    def index
      @offers = Offer.all
    end

    def show; end

    def new
      @offer = Offer.new
    end

    def edit; end

    def create
      @offer = Offer.new(offer_params)
      created = @offer.save
      flash[:notice] = 'Offer successfully created!' if created
      return redirect_to admin_offers_path if created
      flash.now[:error] = "Offer couldn't be created!"
      render :new
    end

    def update
      updated = @offer.update_attributes(offer_params)
      flash[:notice] = 'Offer successfully updated!' if updated
      return redirect_to admin_offers_path if updated
      flash.now[:error] = "Offer couldn't be updated!"
      render :edit
    end

    def destroy
      destroyed = @offer.destroy
      flash[:notice] = 'Offer successfully destroyed!' if destroyed
      return redirect_to admin_offers_path if destroyed
      flash.now[:error] = "Offer couldn't be destroyed!"
      render :show
    end

    private

    def load_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:advertiser_name, :url, :description,
                                    :starts_at, :ends_at, :premium, :disabled)
    end
  end
end
