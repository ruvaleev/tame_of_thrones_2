# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.references :sender, null: false, foreign_key: { to_table: :kingdoms }
      t.references :receiver, null: false, foreign_key: { to_table: :kingdoms }

      t.timestamps
    end
  end
end
