require 'sequel'

module Models
  module V2
    def with_db(database, &block)
      tables = [ Attachment, Chat, Handle, Message ]
      old_dbs = tables.map(&:db)
      tables.each { |t| t.db = database }

      result = yield

      tables.zip(old_dbs).each { |t, db| t.db = db }

      result
    end

    module_function :with_db
  end
end

$:.unshift(File.dirname(__FILE__))

require 'models/v2/attachment'
require 'models/v2/chat'
require 'models/v2/handle'
require 'models/v2/message'