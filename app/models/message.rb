# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender, class_name: :Kingdom, inverse_of: :sent_messages, foreign_key: :sender_id
  belongs_to :receiver, class_name: :Kingdom, inverse_of: :received_messages, foreign_key: :receiver_id

  validates :body, presence: true
end
