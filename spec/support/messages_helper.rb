# frozen_string_literal: true

module MessagesHelper
  def correct_message_to(kingdom_receiver)
    message_text = FFaker::Lorem.sentence.dup
    message_text[rand(message_text.length - 1)] =
      kingdom_receiver.emblem.split('').sort_by { rand }.join
    message_text
  end

  def incorrect_message_to(kingdom_receiver)
    message = FFaker::Lorem.sentence.dup
    message.delete(kingdom_receiver.emblem.last)
  end

  def send_message(receiver_id, message)
    find(".circle img[data-id=\'#{receiver_id}\']").click
    fill_in 'body', with: message
    click_on 'submit_button'
  end
end
