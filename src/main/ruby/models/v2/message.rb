require 'sequel'

class Models::V2::Message < Sequel::Model(:message)
  ZONE = ActiveSupport::TimeZone['UTC']
  EPOCH = ZONE.parse('2001-01-01')

  many_to_one :handle
  one_through_one :chat, join_table: :chat_message_join

  def is_from_me?
    is_from_me == 1
  end

  def timestamp
    ZONE.at(EPOCH.to_i + date)
  end
end