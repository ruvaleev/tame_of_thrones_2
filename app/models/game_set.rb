# frozen_string_literal: true

class GameSet < ApplicationRecord
  has_many :kingdoms, dependent: :destroy
  has_one :player, class_name: :Kingdom, foreign_key: :game_id, dependent: :destroy

  def game_kingdoms
    kingdoms.where(game: nil)
  end

  def create_game_kingdoms
    return if game_kingdoms.size.eql?(6)

    game_kingdoms.destroy_all
    6.times { CreateKingdom.new(id).run }
  end
end
