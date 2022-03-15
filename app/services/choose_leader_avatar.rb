# frozen_string_literal: true

class ChooseLeaderAvatar
  attr_accessor :title, :game_set_id

  AVATARS_TITLES = {
    Queen: [4, 5, 7, 10, 12, 13, 14, 15, 16, 17, 19, 22, 25, 27, 28],
    King: [1, 2, 3, 6, 8, 9, 11, 18, 20, 21, 23, 24, 26, 29, 30, 31]
  }.freeze

  def initialize(title, game_set_id)
    @title = title
    @game_set_id = game_set_id
  end

  def run
    loop do
      avatar_id = AVATARS_TITLES[title].sample
      break avatar_id if Kingdom.find_by(leader_avatar: "king_avatars/#{avatar_id}.png", game_set_id: game_set_id).nil?
    end
  end
end
