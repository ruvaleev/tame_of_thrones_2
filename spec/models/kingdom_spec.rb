# frozen_string_literal: true

require 'rails_helper'
require_relative 'kingdoms_shared_examples'

RSpec.describe Kingdom do
  subject(:kingdom) { build(:kingdom) }

  it { is_expected.to belong_to(:game).inverse_of(:player).optional }
  it { is_expected.to belong_to(:game_set) }
  it { is_expected.to belong_to(:sovereign).class_name(:Kingdom).optional }
  it {
    is_expected.to have_many(:received_messages)
      .class_name(:Message).with_foreign_key(:receiver_id).inverse_of(:receiver).dependent(:nullify)
  }
  it {
    is_expected.to have_many(:sent_messages)
      .class_name(:Message).with_foreign_key(:sender_id).inverse_of(:sender).dependent(:destroy)
  }
  it {
    is_expected.to have_many(:vassals)
      .class_name(:Kingdom).with_foreign_key(:sovereign_id).inverse_of(:sovereign).dependent(:nullify)
  }

  it { is_expected.to validate_presence_of(:leader) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:emblem).scoped_to(:game_set_id) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:game_set_id) }

  context 'with :ruler' do
    let(:game_set) { create(:game_set) }
    let(:not_ruler_in_same_game_set) { create(:kingdom, game_set: game_set, ruler: false) }
    let(:existing_ruler_in_same_game_set) { create(:kingdom, game_set: game_set, ruler: true) }
    let(:existing_ruler_in_other_game_set) { create(:kingdom, ruler: true) }
    let(:kingdom) { build(:kingdom, game_set: game_set, ruler: true) } 

    it 'allows only one ruler in one gameset' do
      expect(kingdom).to be_valid
      
      existing_ruler_in_other_game_set
      expect(kingdom).to be_valid

      not_ruler_in_same_game_set
      expect(kingdom).to be_valid

      existing_ruler_in_same_game_set
      expect(kingdom).not_to be_valid

      kingdom.ruler = false
      expect(kingdom).to be_valid
    end
  end

  # TODO: Or move all logic somewhere OR cover it with tests
  # let(:kingdom_sender) { create(:kingdom) }
  # let(:kingdom_receiver) { create(:kingdom) }

  # describe '#ask_allegiance' do
  #   context "message containing receiver's emblem" do
  #     let(:correct_message) { correct_message_to(kingdom_receiver) }

  #     let(:ask_for_allegiance) { kingdom_sender.ask_for_allegiance(kingdom_receiver, correct_message) }

  #     it 'creates new message' do
  #       expect { ask_for_allegiance }.to change(Message, :count).by(1)
  #     end

  #     it "receiver becames a sender's vassal" do
  #       expect { ask_for_allegiance }.to change(kingdom_sender.vassals, :count).by(1)
  #     end

  #     it "sender becames a receiver's sovereign" do
  #       expect { ask_for_allegiance }.to change(kingdom_receiver, :sovereign_id).from(nil).to(kingdom_sender.id)
  #     end
  #   end

  #   context "message not containing receiver's emblem" do
  #     let(:incorrect_message) { incorrect_message_to(kingdom_receiver) }

  #     let(:ask_for_allegiance) { kingdom_sender.ask_for_allegiance(kingdom_receiver, incorrect_message) }

  #     it 'creates new message' do
  #       expect { ask_for_allegiance }.to change(Message, :count).by(1)
  #     end

  #     it "receiver doesn't became a sender's vassal" do
  #       expect { ask_for_allegiance }.to_not change(kingdom_sender.vassals, :count)
  #     end

  #     it "sender doesn't became a receiver's sovereign" do
  #       expect { ask_for_allegiance }.to_not change(kingdom_receiver, :sovereign_id)
  #     end
  #   end
  # end

  # describe '#greeting' do
  #   let(:kingdom) { create(:kingdom) }
  #   let(:vassal) { create(:kingdom, sovereign: kingdom) }
  #   let(:enemy) { create(:kingdom) }
  #   let(:neutral) { create(:kingdom) }
  #   let!(:message) { create(:message, sender: enemy, receiver: kingdom) }

  #   let(:ally_response) { instance_double(Response) }
  #   let(:enemy_response) { instance_double(Response) }
  #   let(:neutral_response) { instance_double(Response) }

  #   before do
  #     allow(Response).to receive(:new).with(kingdom, vassal, 'ally_greeting').and_return(ally_response)
  #     allow(ally_response).to receive(:send).and_return('some ally greeting')

  #     allow(Response).to receive(:new).with(kingdom, enemy, 'enemy_greeting').and_return(enemy_response)
  #     allow(enemy_response).to receive(:send).and_return('some enemy greeting')

  #     allow(Response).to receive(:new).with(kingdom, neutral, 'neutral_greeting').and_return(neutral_response)
  #     allow(neutral_response).to receive(:send).and_return('some neutral greeting')
  #   end

  #   it 'sends ally_greeting messages to allies' do
  #     expect(kingdom.greeting(vassal)).to eq 'some ally greeting'
  #   end

  #   it 'sends enemy_greeting messages to enemies' do
  #     expect(kingdom.greeting(enemy)).to eq 'some enemy greeting'
  #   end

  #   it 'sends neutral_greeting messages to neutrals' do
  #     expect(kingdom.greeting(neutral)).to eq 'some neutral greeting'
  #   end
  # end

  # describe '.ruler' do
  #   let(:ruler) { create(:kingdom, ruler: true) }

  #   it 'returns nil if there is no ruler' do
  #     expect(described_class.ruler).to eq nil
  #   end

  #   it 'returns Kingdom with ruler flag true' do
  #     ruler
  #     expect(described_class.ruler).to eq ruler
  #   end
  # end

  # describe '#name' do
  #   it_behaves_like 'internationalized_method', 'name'
  # end

  # describe '#emblem' do
  #   it_behaves_like 'internationalized_method', 'emblem'
  # end

  # describe '#leader' do
  #   it_behaves_like 'internationalized_method', 'leader'
  # end

  # describe '#title' do
  #   it_behaves_like 'internationalized_method', 'title'
  # end
end
