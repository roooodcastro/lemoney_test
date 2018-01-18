# frozen_string_literal: true

class CreateOffer < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false
      t.string :url, null: false
      t.string :description, limit: 500, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.boolean :premium, null: false, default: false
      t.boolean :disabled, default: false

      t.timestamps
    end

    add_index :offers, :advertiser_name, unique: true
  end
end
