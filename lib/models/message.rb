require 'sequel'

class Models::Message < Sequel::Model(:message)
  many_to_one :handle
  one_through_one :chat, join_table: :chat_message_join
end