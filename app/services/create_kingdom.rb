# frozen_string_literal: true

class CreateKingdom
  attr_accessor :game_set_id, :game_id, :kingdom_names, :leader_names, :player, :titles

  def initialize(game_set_id, player = false)
    @game_set_id = game_set_id
    @player = player
    @game_id = game_set_id
    @titles = [%i[King Король], %i[Queen Королева]].sample
    @kingdom_names = ChooseKingdomName.new(game_set_id).run
    @leader_names = ChooseLeaderName.new(titles.first, game_set_id).run
  end

  def run
    Kingdom.create(kingdoms_params)
  end

  private

  def kingdoms_params
    special_params = player ? player_params : game_kingdoms_params
    common_params.merge(special_params)
  end

  def common_params
    { name_en: kingdom_names[:en],
      name_ru: kingdom_names[:ru],
      leader_en: leader_names[:en],
      leader_ru: leader_names[:ru],
      title_en: titles.first,
      title_ru: titles.second,
      game_set_id: game_set_id }
  end

  def player_params
    { game_id: game_id }
  end

  def game_kingdoms_params
    leader_avatar_id = ChooseLeaderAvatar.new(titles.first, game_set_id).run
    emblems = ChooseEmblem.new(game_set_id).run
    { emblem_en: emblems[:en],
      emblem_ru: emblems[:ru],
      leader_avatar: "king_avatars/#{leader_avatar_id}.png",
      emblem_avatar: "emblem_avatars/#{emblems[:en].downcase}.png" }
  end
end
