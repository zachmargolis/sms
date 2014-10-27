require 'sequel'

module Models
  module V1
    def with_db(database, &block)
      tables = [ GroupMember, Message ]
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

require 'models/v1/group_member'
require 'models/v1/message'
