# frozen_string_literal: true

# Choose names for kings
class ChooseKingdomName
  attr_accessor :file_path, :game_set_id

  def initialize(game_set_id)
    @file_path = 'public/uploads/kingdoms_names.txt'
    @game_set_id = game_set_id
  end

  def run
    names = find_uniq_kingdom_name

    { ru: names.first, en: names.last }
  end

  private

  def find_uniq_kingdom_name
    loop do
      names = File.read(file_path).split("\n").sample.split(', ')
      break names if Kingdom.find_by(game_set_id: game_set_id, name_en: names.last).nil?
    end
  end
end
