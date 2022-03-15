# frozen_string_literal: true

class Kingdom < ApplicationRecord
  belongs_to :sovereign, class_name: :Kingdom, optional: true, counter_cache: :vassals_count
  belongs_to :game_set
  belongs_to :game, class_name: :GameSet, inverse_of: :player, optional: true
  has_many :vassals, class_name: :Kingdom, foreign_key: :sovereign_id, inverse_of: :sovereign, dependent: :nullify

  with_options class_name: :Message do
    has_many :sent_messages, foreign_key: :sender_id, inverse_of: :sender, dependent: :destroy
    has_many :received_messages, foreign_key: :receiver_id, inverse_of: :receiver, dependent: :nullify
  end

  with_options uniqueness: { scope: :game_set_id } do
    validates :name
    validates :emblem
    validates :ruler, if: :ruler
  end
  validates :name, presence: true
  validates :leader, presence: true

  # TODO: Refactor it!
  # TITLES = {
  #   en: %w[King Queen],
  #   ru: %w[Король Королева]
  # }.freeze

  # MINIMUM_FOR_VICTORY = 3

  # def ask_for_allegiance(kingdom, text)
  #   message = prepare_message(kingdom, text)
  #   agreed = SendEmbassy.new(message).ask_for_allegiance
  #   if agreed
  #     response = 'consent'
  #     new_king = elect_ruler
  #   else
  #     response = 'refusal'
  #     new_king = false
  #   end
  #   [response, Response.new(kingdom, self, response).send, new_king]
  # end

  # def greeting(kingdom)
  #   response = "#{recognize_status(kingdom)}_greeting"
  #   Response.new(self, kingdom, response).send
  # end

  # def self.ruler
  #   find_by(ruler: true)
  # end

  # def name
  #   send("name_#{I18n.locale}")
  # end

  # def emblem
  #   send("emblem_#{I18n.locale}")
  # end

  # def leader
  #   send("leader_#{I18n.locale}")
  # end

  # def title
  #   send("title_#{I18n.locale}")
  # end

  private

  def prepare_message(receiver, text)
    sent_messages.create(receiver: receiver, body: text)
  end

  def recognize_status(kingdom)
    if sovereign_of?(kingdom) || vassal_of?(kingdom)
      'ally'
    elsif got_messages?(kingdom)
      'enemy'
    else
      'neutral'
    end
  end

  def sovereign_of?(kingdom)
    eql?(kingdom.sovereign)
  end

  def vassal_of?(kingdom)
    kingdom.vassals.include?(self)
  end

  def got_messages?(kingdom)
    sent_messages.pluck(:receiver_id).concat(received_messages.pluck(:sender_id)).include?(kingdom.id)
  end

  def elect_ruler
    return if ruler?

    update(ruler: true) if can_be_ruler?
  end

  def can_be_ruler?
    reload
    vassals_count > Kingdom.ruler.try(:vassals_count).to_i &&
      vassals_count >= MINIMUM_FOR_VICTORY
  end
end
