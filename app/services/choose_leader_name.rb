# frozen_string_literal: true

class ChooseLeaderName
  attr_accessor :file_path, :game_set_id

  def initialize(title, game_set_id)
    @file_path = "public/uploads/#{title.downcase}s_names.txt"
    @game_set_id = game_set_id
  end

  def run
    names = find_uniq_leader_name
    { ru: names.first, en: names.last }
  end

  private

  def find_uniq_leader_name
    loop do
      names = File.read(file_path).split("\n").sample.split(', ')
      break names if Kingdom.find_by(leader_en: names.last, game_set_id: game_set_id).nil?
    end
  end
end
