# frozen_string_literal: true

FactoryBot.define do
  factory :kingdom do
    association :game_set
    name { FFaker::Address.country }
    emblem { FFaker::AnimalUS.common_name }
    leader { FFaker::Name.name }
    emblem_avatar { 'support/test_image.png' }
    leader_avatar { 'support/test_image.png' }
  end
end
