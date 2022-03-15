# frozen_string_literal: true

class CreateGameSets < ActiveRecord::Migration[7.0]
  def change
    create_table :game_sets, id: :uuid do |t|
      t.timestamps
    end
  end
end
