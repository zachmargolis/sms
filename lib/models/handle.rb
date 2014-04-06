require 'sequel'

class Models::Handle < Sequel::Model(:handle)
  one_to_many :message
  many_to_many :chats, join_table: :chat_handle_join
end