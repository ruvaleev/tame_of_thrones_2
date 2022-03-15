# frozen_string_literal: true

class Response
  attr_reader :sender, :receiver, :response

  def initialize(sender, receiver, response)
    @sender = sender
    @receiver = receiver
    @response = response
  end

  def send
    string = choose_response
    prepare_message(string)
  end

  private

  def choose_response
    file_path = choose_file_for_parsing(response)
    return if file_path.nil?

    File.read(file_path).split("\n").sample
  end

  def choose_file_for_parsing(response)
    {
      'consent' => "public/uploads/alliance_consent_messages_#{I18n.locale}.txt",
      'refusal' => "public/uploads/alliance_refusal_messages_#{I18n.locale}.txt",
      'ally_greeting' => "public/uploads/ally_greeting_messages_#{I18n.locale}.txt",
      'enemy_greeting' => "public/uploads/enemy_greeting_messages_#{I18n.locale}.txt",
      'neutral_greeting' => "public/uploads/neutral_greeting_messages_#{I18n.locale}.txt"
    }[response]
  end

  def prepare_message(string)
    {
      receiver_name: receiver.name,
      sender_name: sender.name,
      receiver_king: receiver.leader,
      sender_king: sender.leader,
      receiver_title: receiver.title,
      sender_title: sender.title
    }.each { |key, value| string.gsub!("%{#{key}}%", value) }
    string
  end
end
