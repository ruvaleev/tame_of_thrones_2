# frozen_string_literal: true

class CreateKingdoms < ActiveRecord::Migration[7.0]
  def change
    create_table :kingdoms do |t|
      t.references :game, type: :uuid, foreign_key: { to_table: :game_sets }
      t.references :game_set, type: :uuid, foreign_key: true, null: false
      t.references :sovereign, foreign_key: { to_table: :kingdoms }
      t.string :name, null: false, unique: true
      t.string :emblem, null: false, unique: true
      t.string :leader, null: false, unique: true
      t.integer :title, null: false, default: 0
      t.string :emblem_avatar, null: false
      t.string :leader_avatar, null: false
      t.boolean :ruler, null: false, default: false
      t.integer :vassals_count, null: false, default: 0

      t.timestamps
    end
  end
end
