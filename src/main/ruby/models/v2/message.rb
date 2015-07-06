require 'sequel'

class Models::V2::Message < Sequel::Model(:message)
  many_to_one :handle
  one_through_one :chat, join_table: :chat_message_join

  def is_from_me?
    is_from_me == 1
  end
end