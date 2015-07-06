require 'sequel'

class Models::V1::Message < Sequel::Model(:message)
  many_to_many :group_member,
    join_table: :msg_group,
    left_key: :ROWID,
    left_primary_key: :group_id,
    right_key: :ROWID,
    right_primary_key: :group_id

  def is_from_me?
    (flags & 1) == 1
  end

  def service
    'SMS'
  end
end

=begin
require 'sqlite3'
require 'sequel'
require 'logger'

DB = Sequel.connect('sqlite://data/a3e0db62056742567af668635ce33a059659ae1f.sqlite', logger: Logger.new(STDOUT))

$:.unshift('lib')
require 'models/v1'
=end