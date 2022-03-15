# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameSet do
  subject(:game_set) { build(:game_set) }

  it { should have_many(:kingdoms).dependent(:destroy) }
  it { should have_one(:player).class_name('Kingdom').with_foreign_key('game_id').dependent(:destroy) }

  describe '#game_kingdoms' do
    let!(:kingdoms) { create_list(:kingdom, 2, game_set: game_set) }
    let!(:player) { create(:kingdom, game_set: game_set, game: game_set) }

    it 'returns non players kingdoms' do
      expect(game_set.game_kingdoms).to eq kingdoms
    end
  end

  # TODO: Add implementation
  # describe '#create_game_kingdoms' do
  #   let!(:kingdoms) { create_list(:kingdom, rand(6), game_set: game_set) }

  #   it 'creates kingdoms until there are 6 of them' do
  #     expect { game_set.create_game_kingdoms }.to change(Kingdom, :count).to(6)
  #   end
  #   context 'if there are excess kingdoms' do
  #     let!(:kingdoms) { create_list(:kingdom, rand(7..10), game_set: game_set) }

  #     it 'destroys excess kingdoms if there are' do
  #       expect { game_set.create_game_kingdoms }.to change(Kingdom, :count).to(6)
  #     end
  #   end
  # end
end
