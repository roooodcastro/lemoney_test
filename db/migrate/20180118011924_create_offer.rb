# frozen_string_literal: true

class CreateOffer < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false
      t.string :url, null: false
      t.string :description, limit: 500, null: false
      t.date :starts_at, null: false
      t.date :ends_at
      t.boolean :premium, null: false, default: false
      t.boolean :disabled, default: false

      t.timestamps
    end
  end
end
