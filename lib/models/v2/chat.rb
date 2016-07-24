require 'sequel'

class Models::V2::Chat < Sequel::Model(:chat)
  many_to_many :messages, join_table: :chat_message_join
  many_to_many :handles, join_table: :chat_handle_join
end